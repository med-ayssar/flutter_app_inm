import 'package:flutter/material.dart';
import 'package:inm_6/utils/table_cell.dart' as table_row;
import 'package:inm_6/data/data.dart' as data_provider;

typedef MyTableRow = table_row.TableRow;

class Table extends StatefulWidget {
  const Table({super.key});

  @override
  State<Table> createState() => _TableState();
}

class _TableState extends State<Table> {
  List<MyTableRow> rows = [];

  @override
  void initState() {
    super.initState();
    for (var element in data_provider.data) {
      rows.add(MyTableRow.fromJson(element));
    }
  }

  void registerCallBacks(MyTableRow element) {
    element.updateCellCallback = () => setState(() {
          element.changeState();
        });
    element.delete = () {
      setState(() {
        rows.remove(element);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    rows.forEach(registerCallBacks);
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
        child: DataTable(
            dividerThickness: 5,
            dataTextStyle: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            columnSpacing: 40.0, // Adjust this value as needed
            headingRowHeight: 45.0, // Adjust this value as needed
            headingTextStyle: TextStyle(
              fontSize: 25,
              color: Colors.black.withOpacity(0.8),
            ),
            border: TableBorder.all(
                width: 0.5,
                borderRadius: BorderRadius.circular(10),
                color: Colors.deepPurple.shade300),
            headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return Colors.purple.shade50; // Use the default value.
            }),
            columns: const <DataColumn>[
              DataColumn(
                  numeric: false,
                  label: Center(
                    child: Text(
                      "Name",
                      textAlign: TextAlign.center,
                    ),
                  )),
              DataColumn(
                  label: Center(
                child: Text(
                  "Vorname",
                ),
              )),
              DataColumn(label: Center(child: Text("Von"))),
              DataColumn(label: Center(child: Text("Bis"))),
              DataColumn(label: Center(child: Text("Grund"))),
              DataColumn(label: Center(child: Text("Beschreibung"))),
              DataColumn(label: Center(child: Text("Action"))),
            ],
            rows: rows.map((e) => e.getRow()).toList()),
      ),
    );
  }
}
