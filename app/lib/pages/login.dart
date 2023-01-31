/*
  * Utility imports
 */
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  // Route for navigation
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text("login"),
      ),
    );
  }
}
