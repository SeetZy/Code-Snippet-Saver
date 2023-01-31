/*
  * Utility imports
 */
import 'package:flutter/material.dart';

class AddSnippet extends StatelessWidget {
  const AddSnippet({super.key});
  // Route for navigation
  static const routeName = '/add';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text("add"),
      ),
    );
  }
}
