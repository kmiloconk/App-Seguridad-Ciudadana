import 'package:flutter/material.dart';
import 'package:app_prueba/app/ui/routes/routers.dart';

class LoginController {
  void login(BuildContext context, String user, String password) {
    if (user == "user" && password == "1234") {
      Navigator.pushNamed(context, Routes.HOME);
    } else if (user == "admin" && password == "4321") {
      Navigator.pushNamed(context, Routes.EMERGENCI);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials')),
      );
    }
  }
}
