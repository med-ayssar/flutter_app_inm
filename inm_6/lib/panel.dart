import 'package:flutter/material.dart';
import 'package:inm_6/fonts/customIcons.dart';

class Panel extends StatelessWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
        labelType: NavigationRailLabelType.all,
        minWidth: 80,
        indicatorColor: Colors.green[100],
        indicatorShape: const CircleBorder(eccentricity: 0.0),
        useIndicator: true,
        destinations: const [
          NavigationRailDestination(
            icon: Icon(Icons.pending),
            label: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Text("To-DO")
              ],
            ),
          ),
          NavigationRailDestination(
              icon: Icon(Icons.done),
              label: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text("Erledigt"),
                ],
              )),
          NavigationRailDestination(
              icon: Icon(CustomIcons.people_outline),
              label: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text("Mitarbeiter"),
                ],
              )),
          NavigationRailDestination(
              icon: Icon(CustomIcons.settings),
              label: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Text("Einstellung"),
                ],
              ))
        ],
        selectedIndex: 3);
  }
}
