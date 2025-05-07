import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';

class BleBroadcaster {
  final FlutterBlePeripheral _blePeripheral = FlutterBlePeripheral();

  void startBroadcast(String userId) {
    final ephemeralId = _generateEphemeralId(userId);
    final data = utf8.encode(ephemeralId);

    final advertiseData = AdvertiseData(
      includeDeviceName: false,
      manufacturerId: 0xFFFF, // custom ID
      manufacturerData: data,
    );

    _blePeripheral.start(advertiseData: advertiseData);
    print("📡 Broadcasting ID: $ephemeralId");
  }

  void stopBroadcast() {
    _blePeripheral.stop();
  }

  String _generateEphemeralId(String userId) {
    final now = DateTime.now().minute;
    final input = "$userId-$now";
    final hash = sha256.convert(utf8.encode(input)).toString();
    return hash.substring(0, 8);
  }
}
