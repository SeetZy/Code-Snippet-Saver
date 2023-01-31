/*
  * Utility imports
 */
import 'package:flutter/material.dart';
// ? https://pub.dev/packages/bitsdojo_window
import 'package:bitsdojo_window/bitsdojo_window.dart';

/*
  * Page/component imports
 */
import 'app_components/sidebar.dart';
import 'app_components/titlebar.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/add.dart';
import 'package:app/pages/settings.dart';

void main() {
  runApp(const App());

  doWhenWindowReady(() {
    appWindow.minSize = const Size(1200, 650);
    appWindow.title = "Code Snippet Saver";
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Navigation routes
      routes: {
        Home.routeName: (context) => Root(const Home()),
        AddSnippet.routeName: (context) => Root(const AddSnippet()),
        Settings.routeName: (context) => Root(const Settings()),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Root(),
    );
  }
}

// ignore: must_be_immutable
class Root extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  Root([this.child]);
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF110e25),
      body: WindowBorder(
        width: 1,
        color: const Color.fromARGB(255, 14, 14, 14),
        child: Row(
          children: [
            const SideBar(),
            Expanded(
              child: Column(
                children: [
                  const TitleBar(),

                  // ! Checks if child is null
                  // ? if the child is null then the home widget renders
                  // ? if the child isn't null then the selected element from navigation is rendered
                  Expanded(
                    child: child ?? const Home(), //Render child here
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
