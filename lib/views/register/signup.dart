import 'package:flutter/material.dart';
import 'package:timid/services/auth_service.dart';
import 'package:timid/theme/global_colors.dart';
import 'package:timid/views/register/login.dart';
import 'package:timid/views/register/register_name.dart';
import 'package:timid/widgets/button_global.dart';
import 'package:timid/widgets/customTextField.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void signUp() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      var user = await authService.signUpWithEmail(email, password);
      if (user != null) {
        //FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        print("Registro exitoso: ${user.email}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RegisterName()),
        );
      } else {
        print("Error en registro");
      }
    }
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
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 10),
                      const Text(
                        'TIMID',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        'assets/images/LogoTimid.png',
                        width: 55,
                        height: 55,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 150),
                Text('Crea un compte nou',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(height: 50),
                CustomTextField(
                  controller: emailController,
                  label: 'Email',
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  controller: passwordController,
                  label: 'Contrassenya',
                ),
                const SizedBox(height: 30),
                Center(
                  child: ButtonGlobal(
                    text: "Registra’t",
                    onPressed: signUp,
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ja tens un compte?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: const Text(
                          "Inicia sessió",
                          style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
