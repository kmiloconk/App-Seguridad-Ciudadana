import 'package:flutter/material.dart';
import 'package:app_prueba/app/ui/pages/login/login_controller.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cuerpo(context),
    );
  }

  Widget cuerpo(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.blue),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            nombre(),
            campoUsuario(userController),
            campoContrasena(passwordController),
            const SizedBox(
              height: 10,
            ),
            botonEntrar(context, userController, passwordController)
          ],
        ),
      ),
    );
  }

  Widget nombre() {
    return const Text(
      'Sign in',
      style: TextStyle(
          color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold),
    );
  }

  Widget campoUsuario(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: 'user',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }

  Widget campoContrasena(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: TextField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'password',
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
      ),
    );
  }

  Widget botonEntrar(BuildContext context, TextEditingController userController,
      TextEditingController passwordController) {
    return ElevatedButton(
      onPressed: () {
        loginController.login(
            context, userController.text, passwordController.text);
        userController.clear();
        passwordController.clear();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5)),
      child: const Text(
        'Enter',
        style: TextStyle(fontSize: 20, color: Colors.blue),
      ),
    );
  }
}
