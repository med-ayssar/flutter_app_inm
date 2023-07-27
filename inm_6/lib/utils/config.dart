import 'dart:io' show Platform, Directory, File;
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'dart:convert';

Map<String, dynamic> connectionConfig = {
  "host": "",
  "port": 3000,
  "user": "your_user_name",
  "password": " yourpass",
  "database": "database"
};

Future<void> ensureConfigInitialized() async {
  String home = getHome();
  String appConfigFolder = path.join(home, "inm_6_management_app");
  bool exist = await Directory(appConfigFolder).exists();
  if (!exist) {
    // await Directory(appConfigFolder).create(recursive: true);
    await File(path.join(appConfigFolder, "config.json"))
        .create(recursive: true);
    await saveConfigData(connectionConfig);
  } else {
    File file = File(path.join(appConfigFolder, "config.json"));
    bool configExit = file.existsSync();
    if (!configExit) {
      file.createSync();
      await saveConfigData(connectionConfig);
    }
  }
}

String getHome() {
  String home = "";
  Map<String, String> envVars = Platform.environment;
  if (Platform.isMacOS) {
    home = envVars['HOME']!;
  } else if (Platform.isLinux) {
    home = envVars['HOME']!;
  } else if (Platform.isWindows) {
    home = envVars['UserProfile']!;
  }
  return home;
}

String getConfigPath() {
  String home = getHome();
  return path.join(home, "inm_6_management_app", "config.json");
}

Future<void> saveConfigData(Map<String, dynamic> data) async {
  String configData = json.encode(data);
  File file = File(getConfigPath());
  await file.writeAsString(configData);
}

Future<void> setConfigData() async {
  File file = File(getConfigPath());
  final contents = await file.readAsString();
  connectionConfig = jsonDecode(contents);
}
