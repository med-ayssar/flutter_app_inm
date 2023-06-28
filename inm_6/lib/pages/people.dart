import 'package:flutter/material.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:inm_6/data/data.dart';

class People extends StatefulWidget {
  People({super.key}) {
    // TODO: implement People
  }

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: AlphabetScrollView(
                list: names.map((e) => AlphaModel(e)).toList(),
                // isAlphabetsFiltered: false,
                alignment: LetterAlignment.right,
                itemExtent: 50,
                unselectedTextStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                selectedTextStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
                overlayWidget: (value) => Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      size: 50,
                      color: Colors.red,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        // color: Theme.of(context).primaryColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$value'.toUpperCase(),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                itemBuilder: (_, k, id) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ListTile(
                      title: Text('$id'),
                      leading: const Icon(Icons.person),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            names.removeWhere((element) => element == id);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Neuer Mitarbeiter'),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (context) {
                            // Get available height and width of the build area of this widget. Make a choice depending on the size.
                            return const SizedBox(
                              child: NewName(),
                            );
                          },
                        ),
                      );
                    });
                setState(() {});
              },
              tooltip: 'Neuer Mitarbeiter',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class NewName extends StatelessWidget {
  const NewName({super.key});

  @override
  Widget build(BuildContext context) {
    String? NewName = "";
    var key = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: key,
      child: SizedBox(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FormBuilderTextField(
              name: "Name, Vorname",
              initialValue: "",
              onSaved: (newValue) => {NewName = newValue},
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.match(r'[A-Za-z]+, [A-Za-z]+')
              ]),
              decoration: const InputDecoration(
                labelText: 'Name, Vorname',
                contentPadding: EdgeInsets.only(
                  bottom: 3,
                  top: 4,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade300),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: 125,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade300),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        key.currentState!.save();
                        names.add(NewName!);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Bestätigen',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
