import 'package:flutter/material.dart';
import 'package:timid/views/home.dart';
import 'package:timid/widgets/button_global.dart';

class RegisterGender extends StatefulWidget {
  const RegisterGender({super.key});

  @override
  State<RegisterGender> createState() => _RegisterGender();
}

class _RegisterGender extends State<RegisterGender> {
  final TextEditingController userBirthController = TextEditingController();

  void goToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('¿Cuando es tu compleaños?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const SizedBox(height: 35),
                TextFormField(
                  controller: userBirthController,
                  decoration: InputDecoration(hintText: 'Introduce tu nombre'),
                ),
                const SizedBox(height: 20),
                Text('Asi es como se mostrará en tu perfil.'),
                const SizedBox(height: 300),
                ButtonGlobal(text: 'Siguiente', onPressed: goToNextPage)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
