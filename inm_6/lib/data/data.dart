import 'package:mysql_client/mysql_client.dart';
import 'package:inm_6/utils/config.dart' show connectionConfig;
import '../utils/observable.dart' show Names, User;

List<dynamic> data = [];

List<dynamic> doneData = [];

Names observableNames = Names.empty();

final List<String> dropDownOptions = [
  "A?",
  "Url",
  "K?",
  "KO?",
  "DRU",
  "DR",
  "Sonstiges"
];

Future<String> moveData(User user, bool marked) async {
  String toInsertIn = marked ? "todo" : "done";
  String toRemoveFrom = !marked ? "todo" : "done";

  String deleteQuery = 'delete from $toRemoveFrom where ID="${user.id}"';
  String insertQuery =
      'insert into $toInsertIn SET name="${user.name}", vorname="${user.vorname}", von="${convertToSQLDate(user.von!)}", bis="${convertToSQLDate(user.bis!)}", beschreibung="${user.beschreibung}", grund="${user.grund}"';

  await connectToDataBase();

  try {
    await databaseConnection!.execute(deleteQuery);
    await databaseConnection!.execute(insertQuery);
    await fetchToDoData();
    await fetchMarkedData();
  } catch (e) {
    return e.toString();
  }
  closeConnection();
  return "";
}

Future<String> addName(String newName) async {
  List<String> data = newName.split(", ");
  String query =
      'insert into names SET name="${data[0]}", vorname="${data[1]}";';

  await connectToDataBase();

  try {
    await databaseConnection!.execute(query);
    await fetchNames();
  } catch (e) {
    return e.toString();
  }
  closeConnection();
  return "";
}

Future<String> deleteName(String newName) async {
  List<String> data = newName.split(", ");
  String query =
      'delete from names where name="${data[0]}" and vorname="${data[1]}";';

  await connectToDataBase();
  try {
    await databaseConnection!.execute(query);
    await fetchNames();
  } catch (e) {
    return e.toString();
  }
  closeConnection();
  return "";
}

Future<String> delete(User user, bool marked) async {
  String table = marked ? "done" : "todo";

  String deleteQuery = 'delete from $table where ID="${user.id}"';

  await connectToDataBase();

  try {
    await databaseConnection!.execute(deleteQuery);
    await fetchToDoData();
    await fetchMarkedData();
  } catch (e) {
    return e.toString();
  }
  closeConnection();
  return "";
}

Future<String> insertNewEntry(User user) async {
  return await createToDoEntry(user);
}

Future<String> updateUser(User user, bool dest) async {
  await connectToDataBase();
  String table = dest ? "done" : "todo";
  String query =
      'update $table SET name="${user.name}", vorname="${user.vorname}", von="${convertToSQLDate(user.von!)}", bis="${convertToSQLDate(user.bis!)}", beschreibung="${user.beschreibung}", grund="${user.grund}" where ID="${user.id}"';
  try {
    await databaseConnection!.execute(query);
    await fetchToDoData();
  } catch (e) {
    return e.toString();
  }
  closeConnection();
  return "";
}

String convertToSQLDate(String date) {
  return List.from(date.split(".").reversed).join(".");
}

Future<String> createToDoEntry(User user) async {
  bool err = await connectToDataBase();
  String query =
      'insert into todo SET name="${user.name}", vorname="${user.vorname}", von="${convertToSQLDate(user.von!)}",  beschreibung="${user.beschreibung}", bis="${convertToSQLDate(user.bis!)}", grund="${user.grund}"';
  if (err) {
    try {
      await databaseConnection!.execute(query);
      await fetchToDoData();
    } catch (e) {
      return e.toString();
    }
    closeConnection();
    return "";
  }
  return "Failure: No Connection to database";
}

MySQLConnection? databaseConnection;

Future<bool> connectToDataBase() async {
  try {
    int port;
    if (connectionConfig["port"] is String) {
      port = int.parse(connectionConfig["port"]);
    } else {
      port = connectionConfig["port"];
    }
    databaseConnection = await MySQLConnection.createConnection(
      secure: false,
      host: connectionConfig["host"],
      port: port,
      userName: connectionConfig["user"],
      password: connectionConfig["password"],
      databaseName: connectionConfig["database"], // optional
    );

    await databaseConnection!.connect();
    return true;
  } catch (e) {
    return false;
  }
}

void closeConnection() {
  if (databaseConnection!.connected) databaseConnection!.close();
}

Future<List<Map<String, String?>>?> retrievedata(String table) async {
  String query = "SELECT * FROM $table";
  var response = await databaseConnection?.execute(query);
  return response?.rows?.map((e) => e.assoc()).toList().reversed.toList();
}

Future<void> fetchToDoData() async {
  data = (await retrievedata("todo"))!;
}

Future<void> fetchMarkedData() async {
  doneData = (await retrievedata("done"))!;
}

Future<void> fetchNames() async {
  List<dynamic> names_ = (await retrievedata("names"))!;
  observableNames.data =
      names_.map((e) => "${e["name"]}, ${e["vorname"]}").toList();
}

Future<bool> fetchData() async {
  bool succ = await connectToDataBase();
  if (succ) {
    await fetchToDoData();
    await fetchMarkedData();
    await fetchNames();
    closeConnection();
  }
  return succ;
}
