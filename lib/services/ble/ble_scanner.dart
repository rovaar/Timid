import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleScanner {
  final Set<String> detectedIds = {};

  Future<void> startScanning(Function(String id) onDetect) async {
    detectedIds.clear();
    try {
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult result in results) {
          final manufacturerData = result.advertisementData.manufacturerData;

          if (manufacturerData.containsKey(0xFFFF)) {
            final bytes = manufacturerData[0xFFFF]!;
            final userId = utf8.decode(bytes);

            if (!detectedIds.contains(userId)) {
              detectedIds.add(userId);
              onDetect(userId);
              print("Detected User ID: $userId");
            }
          }
        }
      });

      await FlutterBluePlus.startScan();
      print("Started scanning");
    } catch (e) {
      print("Error starting scan: $e");
    }
  }

  Future<void> stopScanning() async {
    try {
      await FlutterBluePlus.stopScan();
      print("Stopped scanning");
    } catch (e) {
      print("Error stopping scan: $e");
    }
  }
}
