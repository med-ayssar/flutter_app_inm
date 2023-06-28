import 'package:flutter/material.dart';
import 'package:inm_6/pages/done.dart';
import 'package:inm_6/pages/new_entry.dart';
import 'package:inm_6/pages/people.dart';
import 'package:inm_6/pages/settings.dart';
import 'package:inm_6/pages/todo.dart';
import 'package:inm_6/panel.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(Size(1600, 800));
  runApp(MainApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Must add this line.
//   await windowManager.ensureInitialized();

//   WindowOptions windowOptions = WindowOptions(
//     size: Size(1300, 600),
//     minimumSize: Size(1300, 600),
//     center: true,
//   );
//   windowManager.waitUntilReadyToShow(windowOptions, () async {
//     await windowManager.show();
//     await windowManager.focus();
//   });

//   runApp(MainApp());
// }

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedPage = 0;
  final List<Widget> pages = <Widget>[
    Entry(),
    TODO(),
    Done(),
    People(),
    Settings()
  ];

  void updatePage(int newSelectedPage) {
    setState(() {
      selectedPage = newSelectedPage;
    });
  }

  Widget getPage(int selectedPage) {
    return TODO();
  }

  @override
  Widget build(BuildContext context) {
    Panel panel = Panel(selectedPage: selectedPage, setPage: updatePage);
    Widget page = pages.elementAt(selectedPage);
    return MaterialApp(
      home: Scaffold(
          body: Row(
        children: [panel, page],
      )),
    );
  }
}
