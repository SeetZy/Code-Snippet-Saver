/*
  * Util/dependency imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';

/*
  * Page/component imports
 */
import 'package:app/components/nav.btn.dart';

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
      color: GlobalVariables.primaryColor,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40),
            height: MediaQuery.of(context).size.height - 74,
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
          const Padding(
            padding: EdgeInsets.only(bottom: 15, left: 15),
            child: SidebarButton(
              title: "Settings",
              icon: Icons.settings,
              route: AppRoutes.settingsRoute,
            ),
          ),
        ],
      ),
    );
  }
}
