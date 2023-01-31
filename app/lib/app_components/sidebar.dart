/*
  * Util/dependency imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 150, maxWidth: 250),
      // Sets the background color
      color: GlobalVariables.secondaryColor,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40),
            height: MediaQuery.of(context).size.height - 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // Home button
                SidebarButton(
                  title: "Overview",
                  icon: Icons.folder,
                  route: AppRoutes.homeRoute,
                ),
                // Add new snippet button
                SidebarButton(
                  title: "Add",
                  icon: Icons.add,
                  route: AppRoutes.addRoute,
                ),
              ],
            ),
          ),
          // Settings button
          const SidebarButton(
            title: "Settings",
            icon: Icons.settings,
            route: AppRoutes.settingsRoute,
          ),
        ],
      ),
    );
  }
}

// Funtion for the button navigation
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
