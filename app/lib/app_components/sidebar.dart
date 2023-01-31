/*
  * Util/dependency imports
 */
import 'package:flutter/material.dart';
// ? https://pub.dev/packages/bitsdojo_window/install
import 'package:bitsdojo_window/bitsdojo_window.dart';
// // ? https://pub.dev/packages/flutter_svg
// import 'package:flutter_svg/flutter_svg.dart';

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
      color: const Color(0xFF110e25),
      child: Column(
        children: [
          WindowTitleBarBox(
            child: MoveWindow(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  children: const [
                    Text(
                      " Code Snippet Saver",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 40),
            height: MediaQuery.of(context).size.height - 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SidebarButton(
                  title: "Overview",
                  icon: Icons.folder,
                  route: '/home',
                ),
                SidebarButton(
                  title: "Add",
                  icon: Icons.add,
                  route: '/add',
                ),
              ],
            ),
          ),
          const SidebarButton(
            title: "Settings",
            icon: Icons.settings,
            route: '/settings',
          ),
        ],
      ),
    );
  }
}

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
          Icon(
            icon,
            color: Colors.white,
          ),
          TextButton(
            onPressed: () {
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
