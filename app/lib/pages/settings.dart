/*
  * Utility imports
 */
import 'package:app/services/auth.service.dart';
import 'package:app/services/user.settings.service.dart';
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
  // Controllers
  final TextEditingController _usernameController =
      TextEditingController(text: UserInfo.username);
  final TextEditingController _emailController =
      TextEditingController(text: UserInfo.email);

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
                Container(
                  width: MediaQuery.of(context).size.width - 90,
                  height: 271,
                  decoration: BoxDecoration(
                    color: GlobalVariables.secondaryColor2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text(
                            'User Settings',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),

                        // Username info
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Text(
                                  'Username: ',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),

                              // Username text input field
                              SizedBox(
                                width: 180,
                                child: TextField(
                                  controller: _usernameController,
                                  decoration: const InputDecoration(
                                    hintText: "Username",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),

                        // Email info
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 45),
                              child: Text(
                                'Email: ',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),

                            // Email text input field
                            SizedBox(
                              width: 180,
                              child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  hintText: "Email",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),

                        // Button to save the data
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            width: 140,
                            child: ElevatedButton(
                              onPressed: () {
                                final String username =
                                    _usernameController.text;
                                final String email = _emailController.text;
                                UserSettings.updateUserData(
                                    context, UserInfo.userId, username, email);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      GlobalVariables.accentColor2),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.save,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Save Data',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const Text(
                          "Note: changes will appear only when you re-log with the new credentials",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
                    onPressed: () {
                      UserSettings.deleteUser(context, UserInfo.userId);
                    },
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
