/*
  * Utility imports
 */
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});
  // Route for navigation
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text("settings"),
      ),
    );
  }
}
