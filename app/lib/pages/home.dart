/*
  * Utility imports
 */
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  // Route for navigation
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("overview"));
  }
}
