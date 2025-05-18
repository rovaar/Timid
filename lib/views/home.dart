import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timid/views/people.dart';
import 'package:timid/views/user_profile/profile.dart';
import 'package:timid/views/chat/chats_home.dart';
import 'package:timid/widgets/bottom_nav_bar.dart';
import 'package:timid/services/ble/ble_broadcaster.dart';
import 'package:timid/services/ble/ble_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timid/services/encounters_service.dart';
import 'dart:io';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> with WidgetsBindingObserver {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final BleBroadcaster _broadcaster = BleBroadcaster();
  final BleScanner _scanner = BleScanner();
  final EncountersService encounterService = EncountersService();
  String? _myUserId;
  int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initBle(); //
  }

  Future<void> _initBle() async {
    await _checkPermissions();

    _myUserId = auth.currentUser!.uid;
    await _startBle();
  }

  Future<void> _checkPermissions() async {
    if (Platform.isAndroid) {
      await Permission.bluetoothAdvertise.request();
      await Permission.bluetoothConnect.request();
      await Permission.bluetoothScan.request();
      await Permission.locationWhenInUse
          .request(); // o locationAlways si lo prefieres
    } else if (Platform.isIOS) {
      await Permission.bluetooth.request();
    }
  }

  Future<void> _startBle() async {
    if (_myUserId != null) {
      await _broadcaster.startBroadcast(_myUserId!);
      await _scanner.startScanning(_handleDetectedId);
    } else {
      print("Error: User ID is null");
      // Handle the error appropriately (e.g., show a message to the user)
    }
  }

  Future<void> _stopBle() async {
    await _broadcaster.stopBroadcast();
    await _scanner.stopScanning();
  }

  void _handleDetectedId(String otherUserId) {
    print('Detected user ID in Home: $otherUserId');
    encounterService.registerEncounter(_myUserId!, otherUserId);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const ProfileScreen(),
      const PeopleScreen(),
      ChatsHomeScreen(),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
