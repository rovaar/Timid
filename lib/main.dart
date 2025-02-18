import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timid/views/register_name.dart';
import 'package:timid/views/splashView.dart';
import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timid',
      home: const SplashView(),
    );
  }
}
