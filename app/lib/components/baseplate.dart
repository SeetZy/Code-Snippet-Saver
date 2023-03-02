/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';

/*
  * Page/component imports
 */
import 'package:app/app_components/sidebar.dart';
import 'package:app/app_components/titlebar.dart';

class Baseplate extends StatelessWidget {
  const Baseplate({super.key, required this.child, required this.title});

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TitleBar(),
          Row(
            children: [
              const SideBar(),
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
    );
  }
}
