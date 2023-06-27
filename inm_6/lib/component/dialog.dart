// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:inm_6/utils/user.dart';

class DataDialog extends StatefulWidget {
  DataDialog({super.key, required this.user});
  User user;
  @override
  State<DataDialog> createState() => _DataDialogState();
}

class _DataDialogState extends State<DataDialog> {
  final formKey = GlobalKey<FormBuilderState>();

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
          FormBuilderTextField(
            name: "Grund",
            initialValue: widget.user.grund,
            onSaved: (newValue) => {widget.user.grund = newValue},
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            decoration: const InputDecoration(
              labelText: 'Grund',
              contentPadding: EdgeInsets.only(
                bottom: 1,
                top: 4,
              ),
            ),
          ),
          FormBuilderTextField(
            name: "Von",
            initialValue: widget.user.von,
            onSaved: (newValue) => {widget.user.von = newValue},
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              labelText: 'Von',
              contentPadding: EdgeInsets.only(
                bottom: 1,
                top: 4,
              ),
            ),
          ),
          FormBuilderTextField(
            name: "Bis",
            initialValue: widget.user.bis,
            onSaved: (newValue) => {widget.user.bis = newValue},
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
            keyboardType: TextInputType.datetime,
            decoration: const InputDecoration(
              labelText: 'Bis',
              contentPadding: EdgeInsets.only(
                bottom: 1,
                top: 4,
              ),
            ),
          ),
          FormBuilderTextField(
            name: "Beschreibung",
            initialValue: widget.user.bis,
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
                width: 100,
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
