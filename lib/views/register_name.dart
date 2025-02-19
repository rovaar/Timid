import 'package:flutter/material.dart';
import 'package:timid/views/register_birth.dart';
import 'package:timid/widgets/button_global.dart';
import 'package:timid/services/user_service.dart';

class RegisterName extends StatefulWidget {
  const RegisterName({super.key});

  @override
  State<RegisterName> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<RegisterName> {
  final TextEditingController userNameController = TextEditingController();
  final RegisterProfile registerProfile = RegisterProfile();

  void goToNextPage() {
    String username = userNameController.text.trim();

    if (username.isNotEmpty) {
      registerProfile.saveName(username);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterBirth()),
      );
    } else {
      print('Error el nombre no esta completo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Cuál es tu nombre?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                    controller: userNameController,
                    decoration:
                        InputDecoration(hintText: 'Introduce tu nombre'),
                  ),
                  const SizedBox(height: 20),
                  Text('Así es como se mostrará en tu perfil.'),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ButtonGlobal(text: 'Siguiente', onPressed: goToNextPage),
            ),
          ],
        ),
      ),
    );
  }
}
