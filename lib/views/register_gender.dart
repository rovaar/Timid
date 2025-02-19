import 'package:flutter/material.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/views/home.dart';
import 'package:timid/widgets/button_global.dart';

class RegisterGender extends StatefulWidget {
  const RegisterGender({super.key});

  @override
  State<RegisterGender> createState() => _RegisterGenderState();
}

class _RegisterGenderState extends State<RegisterGender> {
  final RegisterProfile registerProfile = RegisterProfile();

  // Estado para almacenar la selección del usuario
  String? selectedGender;

  void goToNextPage() {
    if (selectedGender != null) {
      registerProfile.saveGender(selectedGender!);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      print('Por favor, selecciona un género.');
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
                    '¿Cuál es tu género?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  RadioListTile<String>(
                    title: Text("Hombre"),
                    value: "Hombre",
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Mujer"),
                    value: "Mujer",
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("No Binario"),
                    value: "No Binario",
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                ],
              ),

              // Botón centrado en la parte inferior
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
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
