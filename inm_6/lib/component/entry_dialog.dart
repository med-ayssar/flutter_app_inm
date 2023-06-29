// ignore_for_file: depend_on_referenced_packages

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:inm_6/utils/user.dart';
import 'package:inm_6/data/data.dart' as database;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EntryDialog extends StatefulWidget {
  const EntryDialog({super.key});
  @override
  State<EntryDialog> createState() => _EntryDialogState();
}

class _EntryDialogState extends State<EntryDialog> {
  final formKey = GlobalKey<FormBuilderState>();
  final List<String> dropDownOptions = database.dropDownOptions;
  User newUser = User.empty();

  void parseSelectedUser(String value) {
    List<String> splitted = value.split(", ");
    newUser.name = splitted[0];
    newUser.vorname = splitted[1];
  }

  @override
  Widget build(BuildContext context) {
    var data = context.watch<Names>();
    return FormBuilder(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FormBuilderDropdown<String>(
            name: 'Nanme, Vorname',
            initialValue: "${newUser.name}, ${newUser.vorname}",
            onSaved: (newValue) => {parseSelectedUser(newValue!)},
            decoration: const InputDecoration(
              labelText: 'Nanme, Vorname',
            ),
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()]),
            items: data.names
                .map((item) => DropdownMenuItem(
                      alignment: AlignmentDirectional.bottomStart,
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            valueTransformer: (val) => val?.toString(),
          ),
          FormBuilderDropdown<String>(
            name: 'Grund',
            initialValue: newUser.grund,
            onSaved: (newValue) => {newUser.grund = newValue},
            decoration: const InputDecoration(
              labelText: 'Grund',
            ),
            validator: FormBuilderValidators.compose(
                [FormBuilderValidators.required()]),
            items: dropDownOptions
                .map((item) => DropdownMenuItem(
                      alignment: AlignmentDirectional.bottomStart,
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            valueTransformer: (val) => val?.toString(),
          ),
          FormBuilderDateTimePicker(
            name: 'Von',
            format: DateFormat('dd-MM-yyyy'),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            initialValue: DateFormat('dd.MM.yyyy').parse(newUser.von!),
            inputType: InputType.date,
            onSaved: (value) =>
                {newUser.von = "${value?.day}.${value?.month}.${value?.year}"},
            initialTime: const TimeOfDay(hour: 8, minute: 0),
            valueTransformer: (value) =>
                "${value?.day}.${value?.month}.${value?.year}",
          ),
          FormBuilderDateTimePicker(
            name: 'Bis',
            format: DateFormat('dd-MM-yyyy'),
            initialValue: DateFormat('dd.MM.yyyy').parse(newUser.bis!),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            inputType: InputType.date,
            onSaved: (value) =>
                {newUser.bis = "${value?.day}.${value?.month}.${value?.year}"},
            initialTime: const TimeOfDay(hour: 8, minute: 0),
            valueTransformer: (value) =>
                "${value?.day}.${value?.month}.${value?.year}",
          ),
          FormBuilderTextField(
            name: "Beschreibung",
            initialValue: newUser.beschreibung,
            onSaved: (newValue) => {newUser.beschreibung = newValue},
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.maxLength(200)
            ]),
            maxLines: 2,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              labelText: 'Beschreibung',
              contentPadding: EdgeInsets.only(
                bottom: 3,
                top: 4,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade300),
                  onPressed: () {
                    formKey.currentState!.reset();
                  },
                  child: const Text(
                    'Clear',
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
                  onPressed: () async {
                    formKey.currentState!.validate();
                    formKey.currentState!.save();
                    String error = await database.insertNewEntry(newUser);
                    if (error != "") {
                      // ignore: use_build_context_synchronously
                      ElegantNotification.error(
                              title: const Text("New Entry"),
                              description: Text(error))
                          .show(context);
                    } else {
                      ElegantNotification.success(
                              title: Text("New Entry"),
                              description: Text("Your data has been updated"))
                          .show(context);
                    }

                    formKey.currentState!.reset();
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
    );
  }
}
