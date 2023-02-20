/*
  * Utility imports
 */
import 'package:flutter/material.dart';

// Function for the button navigation
class SidebarButton extends StatelessWidget {
  const SidebarButton(
      {required this.icon,
      required this.title,
      required this.route,
      super.key});
  final IconData icon;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          // Button icon
          Icon(
            icon,
            color: Colors.white,
          ),
          // Button name
          TextButton(
            onPressed: () {
              // Redirects to the selected route
              Navigator.of(context).pushNamed(route);
            },
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
