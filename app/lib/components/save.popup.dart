/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';

class SaveSnippet extends StatelessWidget {
  const SaveSnippet({super.key, required this.codeSnippet});

  final TextEditingController codeSnippet;

  @override
  Widget build(BuildContext context) {
    // Pop-up widget content here
    return Container(
      color: GlobalVariables.secondaryColor,
      height: 700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text("Test"),
          )
        ],
      ),
    );
  }
}
