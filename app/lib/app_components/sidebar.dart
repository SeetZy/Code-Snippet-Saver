/*
  * Util/dependency imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';

/*
  * Page/component imports
 */
import 'package:app/app_components/sidebar.btn.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      color: GlobalVariables.primaryColor,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 32,
        child: const Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Home button
                SidebarButton(
                  title: "Home",
                  tooltip: "Home",
                  icon: Icons.folder,
                  route: AppRoutes.homeRoute,
                ),
                // Add new snippet button
                SidebarButton(
                  title: "Add Snippets",
                  tooltip: "Add Snippets",
                  icon: Icons.add,
                  route: AppRoutes.addRoute,
                ),
              ],
            ),

            // Settings button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: SidebarButton(
                  title: "Settings",
                  tooltip: "Settings",
                  icon: Icons.settings,
                  route: AppRoutes.settingsRoute,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
