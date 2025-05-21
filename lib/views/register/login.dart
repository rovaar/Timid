import 'package:flutter/material.dart';
import 'package:timid/services/auth_service.dart';
import 'package:timid/views/home.dart';
import 'package:timid/views/register/signup.dart';
import 'package:timid/widgets/button_global.dart';
import 'package:timid/widgets/customTextField.dart';
import 'package:timid/theme/global_colors.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  void signIn() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      var user = await authService.signInWithEmail(email, password);
      if (user != null) {
        print("Inicio de sesión exitoso: ${user.email}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        print("Error en inicio de sesión");
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
                Text('Inicia sessió al teu compte',
                    style: TextStyle(
                      //color: AppColors.accent,
                      color: Colors.white,
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
                    text: "Inicia sessió",
                    onPressed: signIn,
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("No tens un compte?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                          );
                        },
                        child: const Text(
                          "Registra't",
                          style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Botón 1 presionado');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/GoogleLogo.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        print('Botón 2 presionado');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Image.asset(
                        'assets/images/FacebookLogo.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
