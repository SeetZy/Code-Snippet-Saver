/*
  * Util/dependency imports
 */
import 'package:flutter/material.dart';
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
      color: const Color(0xFF110e25),
      child: Column(
        children: [
          WindowTitleBarBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: MoveWindow(),
                ),
                const WindowButtons()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(),
        MaximizeWindowButton(),
        CloseWindowButton(),
      ],
    );
  }
}
