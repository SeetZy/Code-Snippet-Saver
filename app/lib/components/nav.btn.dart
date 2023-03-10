/*
  * Utility imports
 */
import 'package:flutter/material.dart';

class SidebarButton extends StatelessWidget {
  const SidebarButton(
      {required this.icon,
      required this.title,
      required this.route,
      super.key});

  // Define the required variables for the SidebarButton widget
  final IconData icon;
  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        children: [
          // Add the button icon
          Icon(
            icon,
            color: Colors.white,
          ),
          // Add the button text with a TextButton widget
          TextButton(
            onPressed: () {
              // Navigate to the selected route when the button is clicked
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
