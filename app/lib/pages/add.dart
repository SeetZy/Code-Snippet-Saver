/*
  * Utility imports
 */
import 'package:flutter/material.dart';

/*
  * Page/Component imports
 */

import 'package:app/components/template.dart';

class AddSnippet extends StatelessWidget {
  const AddSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Template(
      title: 'Add Snippet',
      child: Content(),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          "add",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
