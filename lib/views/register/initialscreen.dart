import 'package:flutter/material.dart';
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
                      'assets/images/LogoText.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  const SizedBox(height: 80),
                  Image.asset(
                    'assets/images/PeopleKiss.png',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 80),
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
              const Spacer(),
              Column(
                children: [
                  ButtonGlobal(
                    text: "Sign up",
                    onPressed: signUp,
                  ),
                  const SizedBox(height: 20),
                  ButtonGlobal(
                    text: "Sign in",
                    onPressed: signIn,
                  ),
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
