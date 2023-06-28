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

  void updateName(User oldUser) {
    name = oldUser.name;
    vorname = oldUser.vorname;
    grund = oldUser.grund;
    von = oldUser.von;
    bis = oldUser.bis;
    beschreibung = oldUser.beschreibung;
    notifyListeners();
  }

  String operator [](String label) {
    Map<String, String> data = {
      "name": name!,
      "vorname": vorname!,
      "grund": grund!,
      "von": von!,
      "bis": bis!,
      "beschreibung": beschreibung!
    };
    return data[label]!;
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
