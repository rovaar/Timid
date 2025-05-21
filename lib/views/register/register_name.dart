import 'package:flutter/material.dart';
import 'package:timid/views/register/register_birth.dart';
import 'package:timid/widgets/button_global.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/widgets/customTextField.dart';

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
                    'Quin és el seu nom?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  CustomTextField(
                    controller: userNameController,
                    label: 'Introdueix el teu nom',
                  ),
                  const SizedBox(height: 20),
                  Text('Així és com apareixerà al seu perfil'),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: ButtonGlobal(text: 'Següent', onPressed: goToNextPage),
            ),
          ],
        ),
      ),
    );
  }
}
