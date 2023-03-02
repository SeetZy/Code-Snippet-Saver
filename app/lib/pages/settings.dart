/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import '../services/user.info.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/baseplate.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return const Baseplate(
      title: 'Settings',
      child: Content(),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Settings of ${UserInfo.email}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),

        // Button to add new snippets
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.extended(
            backgroundColor: GlobalVariables.accentColor3,
            elevation: 0,
            onPressed: () {},
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
