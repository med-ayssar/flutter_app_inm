import 'package:flutter/material.dart';
import 'package:inm_6/pages/done.dart';
import 'package:inm_6/pages/people.dart';
import 'package:inm_6/pages/settings.dart';
import 'package:inm_6/pages/todo.dart';
import 'package:inm_6/panel.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedPage = 0;
  final List<Widget> pages = <Widget>[TODO(), Done(), People(), Settings()];

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
