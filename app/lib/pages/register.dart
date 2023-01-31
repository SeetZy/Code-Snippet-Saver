/*
  * Utility imports
 */
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});
  // Route for navigation
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text("register"),
      ),
    );
  }
}
