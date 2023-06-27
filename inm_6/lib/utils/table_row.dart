import 'package:flutter/material.dart';
import 'package:inm_6/component/dialog.dart';
import 'package:inm_6/component/grund.dart';
import 'package:inm_6/utils/user.dart';
import 'package:provider/provider.dart';

typedef RowCallBack = void Function();
typedef DialogFuture = Future<User?> Function();

class TableRow {
  TableRow(
      {required String name,
      required String vorname,
      required String grund,
      required String von,
      required String bis,
      String beschreibung = "K.A",
      this.isMarked = false})
      : _user = User(
            name: name,
            vorname: vorname,
            beschreibung: beschreibung,
            von: von,
            bis: bis,
            grund: grund);

  User _user;
  DialogFuture? updateCellCallback;
  RowCallBack? deleteCallback;

  final bool isMarked;
  bool editable = false;

  User get user => _user;
  void set(User newUser) => _user = newUser;

  factory TableRow.fromJson(Map<String, dynamic> rowData) {
    return TableRow(
        name: rowData["name"],
        vorname: rowData["vorname"],
        von: rowData["von"],
        bis: rowData["bis"],
        beschreibung: rowData["beschreibung"],
        grund: rowData["grund"]);
  }

  set editCell(DialogFuture callback) => updateCellCallback = callback;
  set delete(RowCallBack callback) => deleteCallback = callback;

  void changeState() {
    editable = !editable;
  }

  Name? name;

  DataRow getRow() {
    return DataRow(selected: editable, cells: <DataCell>[
      DataCell(ChangeNotifierProvider(
        create: (context) => _user,
        child: Name(),
      )),
      DataCell(Text(user.vorname!)),
      DataCell(Text(user.von!)),
      DataCell(Text(user.bis!)),
      DataCell(
        Grund(
          value: user.grund!,
          inEditMode: false,
        ),
      ),
      DataCell(Text(user.beschreibung!)),
      DataCell(Row(
        children: [
          IconButton(
              tooltip: "Anpassen",
              onPressed: () async {
                User? newUser = await updateCellCallback!();
                if (newUser != null) {
                  _user.updateName(newUser.name!);
                }
              },
              icon: const Icon(
                Icons.edit,
              )),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.done_all_sharp),
            tooltip: "Markiern",
          ),
          IconButton(
            onPressed: deleteCallback,
            icon: const Icon(Icons.delete_forever_outlined),
            tooltip: "Loeschen",
          )
        ],
      ))
    ]);
  }
}

class Name extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = context.watch<User>();
    return Text(user.name!);
  }
}
