import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inm_6/data/data.dart' as database;

class Names with ChangeNotifier {
  Names({required this.names});
  factory Names.empty() {
    return Names(names: <String>[]);
  }
  List<String> names;

  set data(List<String> otherNames) {
    names = otherNames;
    names.sort();
    notifyListeners();
  }

  bool _disposed = false;

  Future<String> removeName(String newName) async {
    names.removeWhere((e) => e == newName);
    String err = await database.deleteName(newName);
    notifyListeners();
    return err;
  }

  Future<String> addName(String newName) async {
    names.add(newName);
    String err = await database.addName(newName);
    notifyListeners();
    return err;
  }

  @override
  void dispose() {
    if (!_disposed) {
      super.dispose();
      _disposed = true;
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}

class User with ChangeNotifier {
  User(
      {this.id,
      this.name,
      this.vorname,
      this.grund,
      this.von,
      this.bis,
      this.beschreibung});

  String? id;
  String? name;
  String? vorname;
  String? grund;

  String? von;
  String? bis;
  String? beschreibung;

  factory User.empty() {
    return User(
        name: "",
        vorname: "",
        grund: "none",
        von: DateFormat("dd.MM.yyyy").format(DateTime.now()),
        bis: DateFormat("dd.MM.yyyy").format(DateTime.now()),
        beschreibung: "",
        id: "-1");
  }

  bool _disposed = false;

  Future<String> updateUser(User oldUser, bool marked) async {
    name = oldUser.name;
    vorname = oldUser.vorname;
    grund = oldUser.grund;
    von = oldUser.von;
    bis = oldUser.bis;
    beschreibung = oldUser.beschreibung;
    String err = await database.updateUser(this, marked);
    notifyListeners();
    return err;
  }

  String operator [](String label) {
    Map<String, String> data = {
      "name": name!,
      "vorname": vorname!,
      "grund": grund!,
      "von": von!,
      "bis": bis!,
      "beschreibung": beschreibung!,
      "id": id!,
    };
    return data[label]!;
  }

  @override
  String toString() {
    return "id=${id}, name={$name}, vorname={$vorname}, grund={$grund}, von={$von}, bis={$bis}, beschreibung={$beschreibung}";
  }

  Map<String, String> toMap() {
    Map<String, String> res = {
      "id": id!,
      "name": name!,
      "vorname": vorname!,
      "von": von!,
      "bis": bis!,
      "grund": grund!,
      "beschreibung": beschreibung!
    };
    return res;
  }

  @override
  void dispose() {
    if (!_disposed) {
      super.dispose();
      _disposed = true;
    }
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
