import 'package:flutter/material.dart';

class Grund extends StatefulWidget {
  const Grund({super.key, required this.value, required this.inEditMode});

  final String value;
  final bool inEditMode;

  @override
  State<Grund> createState() => _GrundState();
}

class _GrundState extends State<Grund> {
  String currentValue = "";
  bool inEditMode = false;

  void updateValue(String? t) {
    if (t != null) {
      setState(() {
        currentValue = t;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    currentValue = widget.value;
    inEditMode = widget.inEditMode;
  }

  @override
  Widget build(BuildContext context) {
    inEditMode = widget.inEditMode;
    return !inEditMode
        ? Center(child: Text(currentValue))
        : DropdownButtonFormField(
            value: currentValue,
            focusColor: Colors.green.shade50,
            dropdownColor: Colors.blue[50],
            iconEnabledColor: Colors.blue,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold),
            alignment: AlignmentDirectional.center,
            decoration: const InputDecoration(border: UnderlineInputBorder()),
            iconSize: 40,
            isExpanded: true,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            elevation: 10,
            items: const <DropdownMenuItem<String>>[
              DropdownMenuItem<String>(
                value: "1",
                alignment: Alignment.center,
                child: Center(child: Text("1")),
              ),
              DropdownMenuItem<String>(
                alignment: Alignment.center,
                value: "2",
                child: Text("2"),
              ),
            ],
            onChanged: updateValue);
  }
}
