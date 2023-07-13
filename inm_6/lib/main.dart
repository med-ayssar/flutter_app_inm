import 'package:flutter/material.dart';
import 'package:inm_6/pages/done.dart';
import 'package:inm_6/pages/new_entry.dart';
import 'package:inm_6/pages/people.dart';
import 'package:inm_6/pages/settings.dart';
import 'package:inm_6/pages/todo.dart';
import 'package:inm_6/panel.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:inm_6/data/data.dart' as database;
import 'package:provider/provider.dart';
import 'package:inm_6/utils/config.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';


void main() async {
  await ensureConfigInitialized();
  await setConfigData();
  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(const Size(1600, 800));
  await database.fetchData();

  runApp(
    Phoenix(
      child: MainApp(),
    ),
  );
}

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
    Settings(
      data: connectionConfig,
    )
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
      home: ChangeNotifierProvider(
        create: (context) => database.observableNames,
        child: Scaffold(
            body: Row(
          children: [panel, page],
        )),
      ),
    );
  }
}
