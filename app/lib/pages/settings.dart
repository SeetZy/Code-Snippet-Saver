/*
  * Utility imports
 */
import 'package:app/services/auth.service.dart';
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
    return Baseplate(
      title: 'Settings',
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                        fontSize: 25,
                        color: GlobalVariables.accentColor4,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  'Email: ${UserInfo.email}',
                  style: const TextStyle(fontSize: 15),
                )
              ],
            ),
          ),

          // Buttons
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              children: [
                // Button to delete profile
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.accentColor3,
                    ),
                    child: const Text(
                      "Delete profile",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                // Button to logout
                FloatingActionButton.extended(
                  backgroundColor: GlobalVariables.accentColor3,
                  onPressed: () {
                    AuthService.logout(context);
                  },
                  label: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
