import 'dart:convert';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleScanner {
  final Set<String> detectedIds = {};

  void startScanning(Function(String id) onDetect) {
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        final manufacturerData = result.advertisementData.manufacturerData;

        if (manufacturerData.containsKey(0xFFFF)) {
          final bytes = manufacturerData[0xFFFF]!;
          final id = utf8.decode(bytes);

          if (!detectedIds.contains(id)) {
            detectedIds.add(id);
            onDetect(id);
            print("✅ Detected ID: $id");
          }
        }
      }
    });

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 30));
  }

  void stopScanning() {
    FlutterBluePlus.stopScan();
  }
}
