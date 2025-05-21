import 'package:flutter/material.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/theme/global_colors.dart';
import 'package:timid/views/register/register_photos.dart';
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
        MaterialPageRoute(builder: (context) => RegisterPhotos()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Debes selecionar una opcion')),
      );
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
                    'Quin és el teu gènere?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  RadioListTile<String>(
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: "Home",
                    groupValue: selectedGender,
                    activeColor: AppColors.accent,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(
                      "Dona",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: "Dona",
                    groupValue: selectedGender,
                    activeColor: AppColors.accent,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text(
                      "No Binari",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: "No Binari",
                    groupValue: selectedGender,
                    activeColor: AppColors.accent,
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
                  child: ButtonGlobal(text: 'Següent', onPressed: goToNextPage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
