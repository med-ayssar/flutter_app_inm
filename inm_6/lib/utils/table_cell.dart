import 'package:flutter/material.dart';
import 'package:inm_6/component/grund.dart';

typedef RowCallBack = void Function();

class TableRow {
  TableRow(
      {required this.name,
      required this.vorname,
      required this.grund,
      required this.von,
      required this.bis,
      this.isMarked = false,
      this.beschreibung = "K.A"});

  final String name;
  final String vorname;
  final String grund;

  final String von;
  final String bis;
  final String beschreibung;

  RowCallBack? updateCellCallback;
  RowCallBack? deleteCallback;

  final bool isMarked;
  bool editable = false;

  factory TableRow.fromJson(Map<String, dynamic> rowData) {
    return TableRow(
        name: rowData["name"],
        vorname: rowData["vorname"],
        von: rowData["von"],
        bis: rowData["bis"],
        beschreibung: rowData["beschreibung"],
        grund: rowData["grund"]);
  }

  set editCell(RowCallBack callback) => updateCellCallback = callback;
  set delete(RowCallBack callback) => deleteCallback = callback;

  void changeState() {
    editable = !editable;
  }

  DataRow getRow() {
    return DataRow(selected: editable, cells: <DataCell>[
      DataCell(Text(name)),
      DataCell(Text(vorname)),
      DataCell(Text(von), showEditIcon: editable),
      DataCell(Text(bis), showEditIcon: editable),
      DataCell(
        Grund(
          value: grund,
          inEditMode: editable,
        ),
      ),
      DataCell(Text(beschreibung), showEditIcon: editable),
      DataCell(Row(
        children: [
          IconButton(
              tooltip: "Anpassen",
              onPressed: updateCellCallback,
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
