import 'package:flutter/material.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/theme/global_colors.dart';
import 'package:timid/views/register/register_gender.dart';
import 'package:timid/widgets/button_global.dart';

class RegisterBirth extends StatefulWidget {
  @override
  _RegisterBirthState createState() => _RegisterBirthState();
}

class _RegisterBirthState extends State<RegisterBirth> {
  final TextEditingController userBirthController = TextEditingController();
  final RegisterProfile registerProfile = RegisterProfile();
  DateTime? selectedDate;

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        userBirthController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  void goToNextPage() {
    if (selectedDate != null) {
      registerProfile.saveBirth(selectedDate);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterGender()),
      );
    } else {
      print("Por favor, ingresa tu fecha de nacimiento");
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
                    'Quan és el seu aniversari??',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                    controller: userBirthController,
                    readOnly: true,
                    onTap: () => selectDate(context),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Data de naixement',
                      labelStyle: TextStyle(color: Colors.white70),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      suffixIcon:
                          Icon(Icons.calendar_today, color: AppColors.accent),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Així és com apareixerà al seu perfil')
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: ButtonGlobal(
                    text: 'Següent',
                    onPressed: goToNextPage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
