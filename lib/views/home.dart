import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timid/views/login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _logout(context)), // Botón de logout
        ],
      ),
      body: const Center(
        child: Text(
          'Bienvenido a la app!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
