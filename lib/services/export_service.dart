import 'dart:io';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'sort_storage_service.dart';

class ExportResult {
  const ExportResult({required this.path});

  final String path;
}

class ExportService {
  ExportService({required this.storage});

  final SortStorageService storage;

  Future<Directory> _getExportDirectory() async {
    Directory directory;

    if (Platform.isAndroid) {
      final externalDirs = await getExternalStorageDirectories();
      if (externalDirs != null && externalDirs.isNotEmpty) {
        final documentsRoot = externalDirs.first.path.replaceAll(
          RegExp(r'/Android/data/[^/]+/files$'),
          '',
        );
        directory = Directory('$documentsRoot/Documents/InboundSortingRecords');
      } else {
        directory = Directory('/storage/emulated/0/Documents/InboundSortingRecords');
      }
    } else {
      final docs = await getApplicationDocumentsDirectory();
      directory = Directory('${docs.path}/InboundSortingRecords');
    }

    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    return directory;
  }

  Future<ExportResult> exportHistory() async {
    final hasData = await storage.hasHistoryData();
    if (!hasData) {
      throw StateError('empty');
    }

    final historyFile = await storage.getHistoryFile();
    if (!await historyFile.exists()) {
      throw StateError('empty');
    }

    final exportDir = await _getExportDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final exportFile = File('${exportDir.path}/sort_history_$timestamp.json');
    await historyFile.copy(exportFile.path);

    return ExportResult(path: exportFile.path);
  }
}
