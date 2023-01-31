/*
  * Util/dependency imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
// ? https://pub.dev/packages/bitsdojo_window/install
import 'package:bitsdojo_window/bitsdojo_window.dart';

class TitleBar extends StatefulWidget {
  const TitleBar({super.key});

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: GlobalVariables.secondaryColor,
      child: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Movable side of window title bar
                Expanded(
                  child: MoveWindow(
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0, top: 5),
                      // Sets the window titlebar title
                      child: Text(
                        "Code Snippet Saver",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                // Uses the window button widget
                const WindowButtons()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for the custom desktop window buttons
class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Buttons from the bitsdojo library
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        CloseWindowButton(),
      ],
    );
  }
}
