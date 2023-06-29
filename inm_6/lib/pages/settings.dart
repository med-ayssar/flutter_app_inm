import 'dart:io';

import 'package:flutter/material.dart';

// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:inm_6/utils/config.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class Settings extends StatelessWidget {
  Settings({super.key, required this.data}) {
    // TODO: implement Settings
  }
  Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SettingDialog(
            data: data,
          ),
        ),
      ),
    );
  }
}

class SettingDialog extends StatefulWidget {
  SettingDialog({super.key, required this.data});
  Map<String, dynamic> data;
  @override
  State<SettingDialog> createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  final formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> config = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: "Host",
                initialValue: widget.data["host"],
                onSaved: (newValue) => {config["host"] = newValue!},
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                decoration: const InputDecoration(
                  labelText: 'Host',
                  contentPadding: EdgeInsets.only(
                    bottom: 1,
                    top: 10,
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: "Port",
                initialValue: widget.data["port"].toString(),
                onSaved: (newValue) => {config["port"] = newValue!},
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.maxLength(4),
                  FormBuilderValidators.integer(),
                ]),
                decoration: const InputDecoration(
                  labelText: 'Port',
                  contentPadding: EdgeInsets.only(
                    bottom: 1,
                    top: 10,
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: "User",
                initialValue: widget.data["user"],
                onSaved: (newValue) => {config["user"] = newValue!},
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                decoration: const InputDecoration(
                  labelText: 'User',
                  contentPadding: EdgeInsets.only(
                    bottom: 1,
                    top: 10,
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: "Password",
                initialValue: widget.data["password"],
                obscureText: true,
                onSaved: (newValue) => {config["password"] = newValue!},
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  contentPadding: EdgeInsets.only(
                    bottom: 1,
                    top: 10,
                  ),
                ),
              ),
            ),
          ),
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormBuilderTextField(
                name: "Database",
                initialValue: widget.data["database"],
                onSaved: (newValue) => {config["database"] = newValue!},
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
                decoration: const InputDecoration(
                  labelText: 'Database',
                  contentPadding: EdgeInsets.only(
                    bottom: 1,
                    top: 10,
                  ),
                ),
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
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade300),
                  onPressed: () async {
                    formKey.currentState!.validate();
                    formKey.currentState!.save();
                    ensureConfigInitialized();
                    await saveConfigData(config);
                    // Phoenix.rebirth(context);
                    exit(0);
                  },
                  child: const Text(
                    'Speichern & Neu Starten!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
    );
  }
}
