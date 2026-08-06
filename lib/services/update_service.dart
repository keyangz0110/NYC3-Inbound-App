import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:open_filex/open_filex.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:convert';

import 'update_settings_service.dart';

class AppUpdateInfo {
  const AppUpdateInfo({
    required this.versionCode,
    required this.versionName,
    required this.apkUrl,
    this.releaseNotes,
  });

  final int versionCode;
  final String versionName;
  final String apkUrl;
  final String? releaseNotes;

  factory AppUpdateInfo.fromJson(Map<String, dynamic> json) {
    final versionCode = json['versionCode'];
    final apkUrl = json['apkUrl']?.toString().trim() ?? '';
    if (versionCode is! int && versionCode is! num) {
      throw const FormatException('versionCode missing or invalid');
    }
    if (apkUrl.isEmpty) {
      throw const FormatException('apkUrl missing');
    }

    return AppUpdateInfo(
      versionCode: (versionCode as num).toInt(),
      versionName: json['versionName']?.toString() ?? versionCode.toString(),
      apkUrl: apkUrl,
      releaseNotes: json['releaseNotes']?.toString(),
    );
  }
}

enum UpdateCheckStatus {
  upToDate,
  updateAvailable,
  notConfigured,
  error,
}

class UpdateCheckResult {
  const UpdateCheckResult({
    required this.status,
    this.remote,
    this.currentVersionCode,
    this.currentVersionName,
    this.message,
  });

  final UpdateCheckStatus status;
  final AppUpdateInfo? remote;
  final int? currentVersionCode;
  final String? currentVersionName;
  final String? message;
}

typedef DownloadProgress = void Function(int received, int? total);

class UpdateService {
  UpdateService({required this.updateSettings});

  final UpdateSettingsService updateSettings;

  Future<UpdateCheckResult> checkForUpdate() async {
    final manifestUrl = updateSettings.manifestUrl.trim();
    if (manifestUrl.isEmpty) {
      return const UpdateCheckResult(status: UpdateCheckStatus.notConfigured);
    }

    final packageInfo = await PackageInfo.fromPlatform();
    final currentCode = int.tryParse(packageInfo.buildNumber) ?? 0;
    final currentName = packageInfo.version;

    try {
      final response = await http
          .get(Uri.parse(manifestUrl))
          .timeout(const Duration(seconds: 20));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        return UpdateCheckResult(
          status: UpdateCheckStatus.error,
          currentVersionCode: currentCode,
          currentVersionName: currentName,
          message: 'HTTP ${response.statusCode}',
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('version.json must be an object');
      }

      final remote = AppUpdateInfo.fromJson(decoded);
      if (remote.versionCode > currentCode) {
        return UpdateCheckResult(
          status: UpdateCheckStatus.updateAvailable,
          remote: remote,
          currentVersionCode: currentCode,
          currentVersionName: currentName,
        );
      }

      return UpdateCheckResult(
        status: UpdateCheckStatus.upToDate,
        remote: remote,
        currentVersionCode: currentCode,
        currentVersionName: currentName,
      );
    } catch (e) {
      return UpdateCheckResult(
        status: UpdateCheckStatus.error,
        currentVersionCode: currentCode,
        currentVersionName: currentName,
        message: e.toString(),
      );
    }
  }

  Future<void> downloadAndInstall(
    AppUpdateInfo update, {
    DownloadProgress? onProgress,
  }) async {
    if (!Platform.isAndroid) {
      throw StateError('Updates are only supported on Android');
    }

    final installStatus = await Permission.requestInstallPackages.request();
    if (!installStatus.isGranted) {
      throw StateError('Install permission denied');
    }

    final uri = Uri.parse(update.apkUrl);
    final request = http.Request('GET', uri);
    final streamed = await http.Client().send(request).timeout(
          const Duration(minutes: 10),
        );

    if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
      throw StateError('Download failed: HTTP ${streamed.statusCode}');
    }

    final total = streamed.contentLength;
    final cacheDir = await getTemporaryDirectory();
    final fileName =
        'nyc3-inbound-${update.versionName}+${update.versionCode}.apk';
    final file = File('${cacheDir.path}/$fileName');
    final sink = file.openWrite();
    var received = 0;

    try {
      await for (final chunk in streamed.stream) {
        sink.add(chunk);
        received += chunk.length;
        onProgress?.call(received, total);
      }
      await sink.flush();
    } finally {
      await sink.close();
    }

    final result = await OpenFilex.open(
      file.path,
      type: 'application/vnd.android.package-archive',
    );
    if (result.type != ResultType.done) {
      throw StateError(result.message);
    }
  }
}
