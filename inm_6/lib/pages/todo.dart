import 'package:flutter/material.dart';
import 'package:inm_6/utils/table.dart' as local_table;

class TODO extends StatelessWidget {
  TODO({super.key}) {
    //no-op
  }
// Center(child: localTable.Table());
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: local_table.Table(),
      ),
    );
  }
}
