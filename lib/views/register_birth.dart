import 'package:flutter/material.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/views/register_gender.dart';
import 'package:timid/widgets/button_global.dart';

class RegisterBirth extends StatefulWidget {
  const RegisterBirth({super.key});

  @override
  State<RegisterBirth> createState() => _RegisterBirth();
}

class _RegisterBirth extends State<RegisterBirth> {
  final TextEditingController userBirthController = TextEditingController();
  final RegisterProfile registerProfile = RegisterProfile();

  void goToNextPage() {
    String birth = userBirthController.text.trim();

    if (birth.isNotEmpty) {
      registerProfile.saveBirth(birth);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegisterGender()),
      );
    } else {
      print('Erroe comps');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¿Cuándo es tu cumpleaños?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                    controller: userBirthController,
                    decoration: InputDecoration(
                        hintText: 'Introduce tu fecha de nacimiento'),
                  ),
                  const SizedBox(height: 20),
                  Text('Así es como se mostrará en tu perfil.'),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 1230),
                  child:
                      ButtonGlobal(text: 'Siguiente', onPressed: goToNextPage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
