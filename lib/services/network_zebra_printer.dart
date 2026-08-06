import 'dart:convert';
import 'dart:io';

/// Sends raw ZPL to a Zebra printer over Wi-Fi / TCP (port 9100).
///
/// The zebra_printer plugin discovers network printers but only opens
/// [BluetoothConnection] for status and print — so network IPs fail.
/// Direct TCP is the standard Zebra raw print path for Wi-Fi models.
class NetworkZebraPrinter {
  NetworkZebraPrinter._();

  static const int defaultPort = 9100;
  static const Duration connectTimeout = Duration(seconds: 8);

  /// Returns true if a TCP socket can be opened to [host]:[port].
  static Future<bool> canReach(
    String host, {
    int port = defaultPort,
  }) async {
    Socket? socket;
    try {
      socket = await Socket.connect(host, port, timeout: connectTimeout);
      return true;
    } catch (_) {
      return false;
    } finally {
      await socket?.close();
    }
  }

  /// Prints a single ZPL label over TCP.
  static Future<void> printZpl(
    String host,
    String zpl, {
    int port = defaultPort,
  }) async {
    final socket = await Socket.connect(host, port, timeout: connectTimeout);
    try {
      socket.add(utf8.encode(zpl));
      await socket.flush();
      // Brief pause so the printer accepts the job before the socket closes.
      await Future<void>.delayed(const Duration(milliseconds: 200));
    } finally {
      await socket.close();
    }
  }

  /// Prints multiple ZPL labels on one TCP session.
  static Future<void> printZplBatch(
    String host,
    List<String> zplList, {
    int port = defaultPort,
    void Function(int current, int total)? onProgress,
  }) async {
    if (zplList.isEmpty) {
      throw ArgumentError('ZPL list cannot be empty');
    }

    final socket = await Socket.connect(host, port, timeout: connectTimeout);
    try {
      for (var i = 0; i < zplList.length; i++) {
        onProgress?.call(i + 1, zplList.length);
        socket.add(utf8.encode(zplList[i]));
        await socket.flush();
        // Small gap between labels helps mobile printers keep pace.
        await Future<void>.delayed(const Duration(milliseconds: 150));
      }
      await Future<void>.delayed(const Duration(milliseconds: 200));
    } finally {
      await socket.close();
    }
  }

  /// True if [address] looks like an IPv4 host (optional :port ignored).
  static bool isNetworkAddress(String address) {
    final host = hostFromAddress(address);
    final parts = host.split('.');
    if (parts.length != 4) {
      return false;
    }
    for (final part in parts) {
      final n = int.tryParse(part);
      if (n == null || n < 0 || n > 255) {
        return false;
      }
    }
    return true;
  }

  static String hostFromAddress(String address) {
    final trimmed = address.trim();
    if (trimmed.contains(':') && !trimmed.contains('::')) {
      // host:port (IPv4)
      return trimmed.split(':').first;
    }
    return trimmed;
  }

  static int portFromAddress(String address, {int fallback = defaultPort}) {
    final trimmed = address.trim();
    if (trimmed.contains(':') && !trimmed.contains('::')) {
      final parts = trimmed.split(':');
      if (parts.length == 2) {
        return int.tryParse(parts[1]) ?? fallback;
      }
    }
    return fallback;
  }
}
