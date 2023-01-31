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
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            const Center(
              child: Text("overview"),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, '/add');
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
        ),
      ),
    );
  }
}
