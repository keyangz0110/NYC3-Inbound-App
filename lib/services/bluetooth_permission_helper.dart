import 'package:permission_handler/permission_handler.dart';

class BluetoothPermissionHelper {
  BluetoothPermissionHelper._();

  static Future<bool> ensureGranted() async {
    final permissions = <Permission>[
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse,
    ];

    final statuses = await permissions.request();
    return statuses.values.every((status) => status.isGranted);
  }

  static Future<bool> areGranted() async {
    final scan = await Permission.bluetoothScan.status;
    final connect = await Permission.bluetoothConnect.status;
    final location = await Permission.locationWhenInUse.status;
    return scan.isGranted && connect.isGranted && location.isGranted;
  }
}
