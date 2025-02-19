import 'package:flutter/material.dart';
import 'package:timid/services/user_service.dart';
import 'package:timid/views/register_gender.dart';

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
                    '¿Cuándo es tu cumpleaños?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextField(
                    controller: userBirthController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Selecciona tu fecha de nacimiento',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () => selectDate(context),
                  ),
                  const SizedBox(height: 20),
                  Text('Así es como se mostrará en tu perfil.'),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: ElevatedButton(
                    onPressed: goToNextPage,
                    child: Text('Siguiente'),
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
