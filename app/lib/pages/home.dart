/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/app.routes.dart';

/*
  * Page/Component imports
 */

import 'package:app/components/template.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
    return Stack(
      children: [
        const Center(
          child: Text(
            "Welcome ",
            style: TextStyle(color: Colors.black),
          ),
        ),

        // Button to add new snippets
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.extended(
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addRoute);
            },
            label: const Text(
              "Add\nSnippet",
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
