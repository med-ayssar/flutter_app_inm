import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DataDialog extends StatelessWidget {
  const DataDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        FormBuilderTextField(
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
            FormBuilderValidators.max(70),
          ]),
          name: "Name",
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
                onPressed: () {},
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
                onPressed: () {},
                child: const Text(
                  'Bestätigen',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
