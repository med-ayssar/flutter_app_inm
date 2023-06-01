import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: <Widget>[
        NavigationRail(destinations: const [
          NavigationRailDestination(
              label: Text("To-Do"), icon: Icon(Icons.favorite_border)),
          NavigationRailDestination(
              label: Text("Erledigt"), icon: Icon(Icons.favorite_border)),
          NavigationRailDestination(
              label: Text("Mitarbeiter"), icon: Icon(Icons.favorite_border)),
          NavigationRailDestination(
              icon: Icon(Icons.face_2_sharp), label: Text("Einstellung"))
        ], selectedIndex: 0),
        Container(
          child: Text('PlayGround'),
        )
      ]),
    );
  }
}
