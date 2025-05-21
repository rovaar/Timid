import 'package:flutter/material.dart';
import 'package:timid/theme/global_colors.dart';
import 'package:timid/views/register/login.dart';
import 'package:timid/views/register/signup.dart';
import 'package:timid/widgets/button_global.dart';

class Initialscreen extends StatefulWidget {
  const Initialscreen({super.key});

  @override
  State<Initialscreen> createState() => InitialscreenState();
}

class InitialscreenState extends State<Initialscreen> {
  void signIn() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  void signUp() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignUp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/LogoTimid.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Benveniguts a Timid!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  ButtonGlobal(
                    text: "Iniciar Sessió",
                    onPressed: signIn,
                  ),
                  const SizedBox(height: 20),
                  ButtonGlobal(
                    text: "Registrar-se",
                    onPressed: signUp,
                    backgroundColor: AppColors.background,
                    textColor: AppColors.accent,
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
