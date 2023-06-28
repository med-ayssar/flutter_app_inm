import 'package:flutter/material.dart';
import 'package:inm_6/utils/table.dart' as local_table;

class Done extends StatelessWidget {
  Done({super.key}) {
    // TODO: implement Done
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: const local_table.Table(
          marked: true,
        ),
      ),
    );
  }
}
