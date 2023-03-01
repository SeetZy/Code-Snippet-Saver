/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';
import 'package:app/utils/device.checker.dart';

/*
  * Page/component imports
 */
import 'package:app/components/nav.btn.dart';
import 'package:app/app_components/sidebar.dart';
import 'package:app/app_components/titlebar.dart';

class Baseplate extends StatelessWidget {
  const Baseplate({super.key, required this.child, required this.title});

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeviceCheck().isMobile
          ? AppBar(
              backgroundColor: GlobalVariables.primaryColor,
            )
          : null,
      drawer: DeviceCheck().isMobile
          ? Drawer(
              backgroundColor: GlobalVariables.primaryColor,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 30),
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
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            // Loads the titlebar if the device is a desktop device
            Visibility(
              visible: DeviceCheck().isDesktop,
              child: const TitleBar(),
            ),
            Row(
              children: [
                // Loads the sidebar if the device is a desktop device
                Visibility(
                  visible: DeviceCheck().isDesktop,
                  child: const SideBar(),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 31,
                    color: GlobalVariables.secondaryColor,
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
