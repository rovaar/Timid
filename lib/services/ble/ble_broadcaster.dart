import 'dart:convert';
import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;
import 'dart:typed_data';

class BleBroadcaster {
  final FlutterBlePeripheral _blePeripheral = FlutterBlePeripheral();

  Future<void> _requestPermissions() async {
    await [
      Permission.bluetooth,
      Permission.bluetoothAdvertise,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse, // o Permission.location
    ].request();
  }

  Future<void> _ensureLocationServicesEnabled() async {
    final location = loc.Location();
    final serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      final result = await location.requestService();
      if (!result) {
        print("Ubicación no activada por el usuario.");
        return;
      }
    }
  }

  Future<void> startBroadcast(String userId) async {
    await _requestPermissions();
    await _ensureLocationServicesEnabled();

    final data = Uint8List.fromList(utf8.encode(userId));

    final advertiseData = AdvertiseData(
      manufacturerId: 0xFFFF,
      manufacturerData: data,
    );

    print("Longitud de la ID: ${userId.length}");
    print("ID: $userId");
    print("ID_data: $data");
    print("advertiseData: $advertiseData");
    print("Total advertised data length: ${data.length + 2}");

    try {
      await _blePeripheral.start(advertiseData: advertiseData);
      print("Broadcasting User ID: $userId");
    } catch (e) {
      print("Error starting broadcast: $e");
    }
  }

  Future<void> stopBroadcast() async {
    try {
      await _blePeripheral.stop();
      print("broadcast Detenido!");
    } catch (e) {
      print("Error stopping broadcast: $e");
    }
  }
}
