import 'package:flutter/material.dart';
import 'package:inm_6/utils/observable.dart';
import 'package:provider/provider.dart';
import 'package:inm_6/data/data.dart' as database;

typedef RowCallBack = void Function();
typedef NotifyCallBack = void Function(String, String);
typedef Refresh = void Function();
typedef DialogFuture = Future<User?> Function();

class TableRow {
  TableRow(
      {String id = "-1",
      required String name,
      required String vorname,
      required String grund,
      required String von,
      required String bis,
      String beschreibung = "K.A",
      this.isMarked = false})
      : _user = User(
            id: id,
            name: name,
            vorname: vorname,
            beschreibung: beschreibung,
            von: von,
            bis: bis,
            grund: grund);

  User _user;
  DialogFuture? updateCellCallback;
  RowCallBack? _move;
  NotifyCallBack? _notify;

  final bool isMarked;
  bool editable = false;

  User get user => _user;
  String get id => _user.id!;
  void set(User newUser) => _user = newUser;

  factory TableRow.fromJson(Map<String, dynamic> rowData) {
    return TableRow(
        id: rowData["ID"].toString(),
        name: rowData["name"],
        vorname: rowData["vorname"],
        von: List.from(rowData["von"].split("-").reversed).join("."),
        bis: List.from(rowData["bis"].split("-").reversed).join("."),
        beschreibung: rowData["beschreibung"],
        grund: rowData["grund"]);
  }

  set editCell(DialogFuture callback) => updateCellCallback = callback;
  set move(RowCallBack callback) => _move = callback;
  set nottiy(NotifyCallBack callback) => _notify = callback;

  void changeState() {
    editable = !editable;
  }

  Widget get_edit_action(bool makred, Refresh refresh) {
    if (!makred) {
      return IconButton(
          tooltip: "Anpassen",
          onPressed: () async {
            User? newUser = await updateCellCallback!();
            if (newUser != null) {
              assert(user.id == newUser.id);
              String err = await _user.updateUser(newUser, isMarked);
              _notify!(err, "Update Entry");
              refresh();
            }
          },
          icon: const Icon(
            Icons.edit,
          ));
    }
    return const SizedBox();
  }

  DataRow getRow({bool isMarked = false, required Refresh refresh}) {
    return DataRow(
        // key: ValueKey<String>(user.id!),
        key: UniqueKey(),
        selected: editable,
        cells: <DataCell>[
          DataCell(Element(data: _user.name!)),
          DataCell(Element(data: _user.vorname!)),
          DataCell(Element(data: _user.von!)),
          DataCell(Element(data: _user.bis!)),
          DataCell(Element(data: _user.grund!)),
          DataCell(Element(data: _user.beschreibung!)),
          DataCell(Row(
            children: [
              get_edit_action(isMarked, refresh),
              IconButton(
                onPressed: () async {
                  String err = await database.moveData(_user, isMarked);
                  _notify!(err, "Move Entry");
                  _move!();
                  refresh();
                },
                icon: isMarked
                    ? const Icon(Icons.undo_sharp)
                    : const Icon(Icons.done_all_sharp),
                tooltip: isMarked ? "Unmarkieren" : "Markiern",
              ),
              IconButton(
                onPressed: () async {
                  String err = await database.delete(_user, isMarked);
                  _notify!(err, "Delete Entry");
                  _move!();
                  refresh();
                },
                icon: const Icon(Icons.delete_forever_outlined),
                tooltip: "Loeschen",
              )
            ],
          ))
        ]);
  }
}

class Element extends StatelessWidget {
  final String data;
  const Element({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Text(
        data,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        maxLines: 1,
      ),
    );
  }
}
