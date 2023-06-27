import 'package:flutter/material.dart';

class User with ChangeNotifier {
  User(
      {this.name,
      this.vorname,
      this.grund,
      this.von,
      this.bis,
      this.beschreibung});

  String? name;
  String? vorname;
  String? grund;

  String? von;
  String? bis;
  String? beschreibung;

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  @override
  String toString() {
    return "name={$name}, vorname={$vorname}, grund={$grund}, von={$von}, bis={$bis}, beschreibung={$beschreibung}";
  }
}

class TestUser extends ChangeNotifier {
  int x = 5;
  void remove() {}
}
