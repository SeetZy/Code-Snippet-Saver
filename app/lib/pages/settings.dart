/*
  * Utility imports
 */
import 'package:flutter/material.dart';

/*
  * Page/Component imports
 */

import 'package:app/components/template.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Template(
      childW: Content(),
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
          "settings",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
