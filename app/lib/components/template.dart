/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/app_components/sidebar.dart';
import 'package:app/app_components/titlebar.dart';

class Template extends StatelessWidget {
  const Template({super.key, required this.childW});

  final Widget childW;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TitleBar(),
            Row(
              children: [
                const SideBar(),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height - 31,
                    color: Colors.white,
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: childW,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
