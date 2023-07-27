import 'package:flutter/material.dart';
import 'package:inm_6/component/entry_dialog.dart';

class Entry extends StatelessWidget {
  Entry({super.key}) {
    //no-op
  }
// Center(child: localTable.Table());
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: EntryDialog(),
        ),
      ),
    );
  }
}
