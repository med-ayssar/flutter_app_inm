import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:inm_6/component/dialog.dart';
import 'package:inm_6/utils/table_row.dart' as table_row;
import 'package:inm_6/data/data.dart' as data_provider;
import 'package:inm_6/utils/observable.dart';
import 'package:intl/intl.dart';

typedef MyTableRow = table_row.TableRow;
typedef DialogFactory = Future<User?> Function();

class Table extends StatefulWidget {
  const Table({super.key, required this.marked});
  final bool marked;

  @override
  State<Table> createState() => _TableState();
}

class _TableState extends State<Table> {
  List<MyTableRow> rows = [];
  bool sortByNameAscending = true;
  bool sortByVornameAscending = true;
  bool sortByBisAscending = true;
  bool sortByVonAscending = true;
  bool sortByGrundAscending = true;

  @override
  void initState() {
    super.initState();
    List<dynamic> localData =
        widget.marked ? data_provider.doneData : data_provider.data;

    for (var element in localData) {
      rows.add(MyTableRow.fromJson(element));
    }
  }

  void registerCallBacks(MyTableRow element) {
    element.move = () {
      setState(() {
        // rows.removeWhere((e) => e.id == element.id);
        List<dynamic> localData =
            widget.marked ? data_provider.doneData : data_provider.data;
        rows.clear();
        for (var element in localData) {
          rows.add(MyTableRow.fromJson(element));
        }
      });
    };
  }

  DialogFactory dialogFactory(BuildContext context, User user) {
    Future<User?> dialog() {
      return showDialog<User>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Eintrag Anpassen'),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              content: Builder(
                builder: (context) {
                  // Get available height and width of the build area of this widget. Make a choice depending on the size.
                  var height = MediaQuery.of(context).size.height;
                  var width = MediaQuery.of(context).size.width;

                  return SizedBox(
                    height: 0.60 * height,
                    width: 1 * width / 3,
                    child: DataDialog(
                      user: user,
                    ),
                  );
                },
              ),
            );
          });
    }

    return dialog;
  }

  table_row.NotifyCallBack notify(BuildContext context) {
    void showUpdateState(String err, String title) {
      if (err != "") {
        // ignore: use_build_context_synchronously
        ElegantNotification.error(
                toastDuration: const Duration(seconds: 10),
                title: Text(title),
                description: Text(err))
            .show(context);
      } else {
        ElegantNotification.success(
                title: Text(title),
                description: const Text("Your data has been updated"))
            .show(context);
      }
    }

    return showUpdateState;
  }

  void appendDialogToRow(BuildContext context) {
    for (var element in rows) {
      element.updateCellCallback = dialogFactory(context, element.user);
      element.nottiy = notify(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("rebbuild");
    rows.forEach(registerCallBacks);
    appendDialogToRow(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
        child: DataTable(
            sortColumnIndex: 0,
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
              if (widget.marked) {
                return Colors.yellow.shade50;
              } else {
                return Colors.purple.shade50;
              }
              // Use the default value.
            }),
            columns: <DataColumn>[
              DataColumn(
                  numeric: false,
                  label: const Center(
                    child: Text(
                      "Name",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  onSort: (int columnIndex, bool ascending) => setState(() {
                        if (sortByNameAscending) {
                          rows.sort((a, b) {
                            return a.user.name!.compareTo(b.user.name!);
                          });
                        } else {
                          rows.sort((a, b) {
                            return b.user.name!.compareTo(a.user.name!);
                          });
                        }
                        sortByNameAscending = !sortByNameAscending;
                      })),
              DataColumn(
                  label: const Center(
                    child: Text(
                      "Vorname",
                    ),
                  ),
                  onSort: (int columnIndex, bool ascending) => setState(() {
                        if (sortByVornameAscending) {
                          rows.sort((a, b) {
                            return a.user.vorname!.compareTo(b.user.vorname!);
                          });
                        } else {
                          rows.sort((a, b) {
                            return b.user.vorname!.compareTo(a.user.vorname!);
                          });
                        }
                        sortByVornameAscending = !sortByVornameAscending;
                      })),
              DataColumn(
                  label: const Center(child: Text("Von")),
                  onSort: (int columnIndex, bool x) => setState(() {
                        if (sortByVonAscending) {
                          rows.sort((a, b) {
                            return DateFormat("dd.MM.yyyy")
                                .parse(a.user.von!)
                                .compareTo(DateFormat("dd.MM.yyyy")
                                    .parse(b.user.von!));
                          });
                        } else {
                          rows.sort((a, b) {
                            return DateFormat("dd.MM.yyyy")
                                .parse(b.user.von!)
                                .compareTo(DateFormat("dd.MM.yyyy")
                                    .parse(a.user.von!));
                          });
                        }
                        sortByVonAscending = !sortByVonAscending;
                      })),
              DataColumn(
                  label: const Center(child: Text("Bis")),
                  onSort: (int columnIndex, bool x) => setState(() {
                        if (sortByBisAscending) {
                          rows.sort((a, b) {
                            return DateFormat("dd.MM.yyyy")
                                .parse(a.user.bis!)
                                .compareTo(DateFormat("dd.MM.yyyy")
                                    .parse(b.user.bis!));
                          });
                        } else {
                          rows.sort((a, b) {
                            return DateFormat("dd.MM.yyyy")
                                .parse(b.user.bis!)
                                .compareTo(DateFormat("dd.MM.yyyy")
                                    .parse(a.user.bis!));
                          });
                        }
                        sortByBisAscending = !sortByBisAscending;
                      })),
              DataColumn(
                  label: const Center(child: Text("Grund")),
                  onSort: (int columnIndex, bool x) => setState(() {
                        if (sortByGrundAscending) {
                          rows.sort((a, b) {
                            return a.user.grund!
                                .toLowerCase()
                                .compareTo(b.user.grund!.toLowerCase());
                          });
                        } else {
                          rows.sort((a, b) {
                            return b.user.grund!
                                .toLowerCase()
                                .compareTo(a.user.grund!.toLowerCase());
                          });
                        }
                        sortByGrundAscending = !sortByGrundAscending;
                      })),
              const DataColumn(
                label: Center(child: Text("Beschreibung")),
              ),
              const DataColumn(
                label: Center(child: Text("Action")),
              ),
            ],
            rows: rows.map((e) => e.getRow(isMarked: widget.marked)).toList()),
      ),
    );
  }
}
