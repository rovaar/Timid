// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCWi-K3T3IUFzRmDhpWKzjUHpaQSgaHiJs',
    appId: '1:587775296604:web:c574b13805d3855c039299',
    messagingSenderId: '587775296604',
    projectId: 'timid-17cf8',
    authDomain: 'timid-17cf8.firebaseapp.com',
    storageBucket: 'timid-17cf8.firebasestorage.app',
    measurementId: 'G-76XJ09VB9N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcMNdZhA4X1fvxMaw2r583prOrlyowVBs',
    appId: '1:587775296604:android:abb6e14d81765418039299',
    messagingSenderId: '587775296604',
    projectId: 'timid-17cf8',
    storageBucket: 'timid-17cf8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnh6HaotyWgOKobmECGnhZPogIEqJVsi0',
    appId: '1:587775296604:ios:fdd634acc6c3aacb039299',
    messagingSenderId: '587775296604',
    projectId: 'timid-17cf8',
    storageBucket: 'timid-17cf8.firebasestorage.app',
    iosBundleId: 'com.example.timid',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnh6HaotyWgOKobmECGnhZPogIEqJVsi0',
    appId: '1:587775296604:ios:fdd634acc6c3aacb039299',
    messagingSenderId: '587775296604',
    projectId: 'timid-17cf8',
    storageBucket: 'timid-17cf8.firebasestorage.app',
    iosBundleId: 'com.example.timid',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCWi-K3T3IUFzRmDhpWKzjUHpaQSgaHiJs',
    appId: '1:587775296604:web:0f4b246fa9b7db20039299',
    messagingSenderId: '587775296604',
    projectId: 'timid-17cf8',
    authDomain: 'timid-17cf8.firebaseapp.com',
    storageBucket: 'timid-17cf8.firebasestorage.app',
    measurementId: 'G-MCYERQLMGK',
  );
}
