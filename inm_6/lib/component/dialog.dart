// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:inm_6/utils/observable.dart';
import 'package:intl/intl.dart';
import 'package:inm_6/data/data.dart' as database;

class DataDialog extends StatefulWidget {
  DataDialog({super.key, required this.user});
  User user;
  @override
  State<DataDialog> createState() => _DataDialogState();
}

class _DataDialogState extends State<DataDialog> {
  final formKey = GlobalKey<FormBuilderState>();
  final List<String> dropDownOptions = database.dropDownOptions;
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FormBuilderTextField(
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            onSaved: (newValue) => {widget.user.name = newValue},
            name: "Name",
            initialValue: widget.user.name,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: 'Name',
              contentPadding: EdgeInsets.only(
                bottom: 1,
                top: 4,
              ),
            ),
          ),
          FormBuilderTextField(
            name: "Vorname",
            initialValue: widget.user.vorname,
            onSaved: (newValue) => {widget.user.vorname = newValue},
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: 'Vorname',
              contentPadding: EdgeInsets.only(
                bottom: 1,
                top: 4,
              ),
            ),
          ),
          FormBuilderDropdown<String>(
            name: 'Grund',
            initialValue: widget.user.grund,
            onSaved: (newValue) => {widget.user.grund = newValue},
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
            initialValue: DateFormat('dd.MM.yyyy').parse(widget.user.von!),
            inputType: InputType.date,
            onSaved: (value) => {
              widget.user.von = DateFormat("dd.MM.yyyy").format(value!),
            },
            initialTime: const TimeOfDay(hour: 8, minute: 0),
            valueTransformer: (value) =>
                "${value?.day}.${value?.month}.${value?.year}",
          ),
          FormBuilderDateTimePicker(
            name: 'Bis',
            format: DateFormat('dd-MM-yyyy'),
            initialValue: DateFormat('dd.MM.yyyy').parse(widget.user.bis!),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            inputType: InputType.date,
            onSaved: (value) => {
              widget.user.bis = DateFormat("dd.MM.yyyy").format(value!),
            },
            initialTime: const TimeOfDay(hour: 8, minute: 0),
            valueTransformer: (value) =>
                "${value?.day}.${value?.month}.${value?.year}",
          ),
          FormBuilderTextField(
            name: "Beschreibung",
            initialValue: widget.user.beschreibung,
            onSaved: (newValue) => {widget.user.beschreibung = newValue},
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
                    formKey.currentState!.validate();
                    formKey.currentState!.save();
                    Navigator.pop(context, widget.user);
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
