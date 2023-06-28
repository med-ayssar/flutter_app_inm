import 'dart:convert';

import '../utils/user.dart';

String dataString = '''
[{
  "id":0,
  "name": "Benelhedi",
  "vorname": "Ayssar",
  "grund": "1",
  "von": "21.09.1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"
},
{
  "id":1,
  "name": "45t",
  "vorname": "hh4",
  "grund": "1",
  "von": "21.09.1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"
},
{
  "id":2,
  "name": "xx",
  "vorname": "yy",
  "grund": "1",
  "von": "21.09.1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"
},
{
  "id":3,
  "name": "gg",
  "vorname": "bh",
  "grund": "1",
  "von": "21.09.1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"
},
{
  "id":4,
  "name": "12",
  "vorname": "23",
  "grund": "1",
  "von": "21.09.1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"
},
{
  "id":5,
  "name": "aa",
  "vorname": "bb",
  "grund": "1",
  "von": "21.09.1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"
}
]
''';

List<dynamic> data = jsonDecode(dataString);

List<dynamic> doneData = jsonDecode(dataString);

List<String> names = [
  'Albers, Jasper',
  'Bakker, Rembrandt ',
  'Benelhedi, Ayssar',
  'Barthelemy, Fred',
  'Böttcher, Joshua',
  'Bouss, Peter',
  'Chebrol, Neharika',
  'Dahmen, David ',
  'Denker, Michael ',
  'Dick, Michael',
  'Diesmann, Markus',
  'Elfgen, Anne',
  'Essink, Simon',
  'Ewert, Leander',
  'Finnerty, Justin',
  'Fischer, Angela',
  'Fischer, Kirsten',
  'Gehlich, Lena',
  'Gillessen, Sebastian',
  'Goyer, David',
  'Graber, Steffen',
  'Grün, Sonja',
  'Gutzen, Robin',
  'Helias, Moritz ',
  'Ito, Junji',
  'Kern, Moritz',
  'Kleinjohann, Alexander',
  'Kloss, Oliver',
  'Köhler, Cristiano',
  'Köhn, Clemens',
  'Kramer, Max',
  'Krauße, Sven',
  'Kurth, Anno',
  'Lehm, Janine',
  'Li, Xiuzhi',
  'Lindner, Javed',
  'Lober, Melissa',
  'Meißner, Saskia',
  'Michels, Tobias',
  'Mitchell, Jessica',
  'Morales, Aitor',
  'More, Heather',
  'Morrison, Abigail',
  'Nestler, Sandra',
  'Oberländer, Jette',
  'Oberste-Frielinghaus, Jonas',
  "O'Brien, Petra",
  'Oliveira Shimoura, Renan',
  'Palm, Günther',
  'Paoletti, Monica',
  'Peraza Coppola, Gorka',
  'Plesser, Hans Ekkehard',
  'Reske, Martina',
  'René, Alexandre',
  'Riehle, Alexa',
  'Schulte to Brinke, Tobias',
  'Schutzeichel, Lars',
  'Senk, Johanna',
  'Terhorst, Dennis',
  'Tetzlaff, Tom',
  'Theinen, Silas',
  'Tiberi, Lorenzo',
  'van Albada, Sacha ',
  'Villamar, Jose',
  'Vogelsang, Jan',
  'Wybo, Willem',
  'Zajzon, Barna'
];

void moveData(User user, bool dest) {
  List<dynamic> toInsertIn = dest ? doneData : data;
  List<dynamic> toRemoveFrom = dest ? data : doneData;

  user.id = (toInsertIn.length + 1).toString();
  toInsertIn.add(user.toMap());

  toRemoveFrom.removeWhere((element) => element["id"] == user.id);
}

void insertNewEntry(User user) {
  user.id = (data.length + 1).toString();
  print(data);
  data.add(user.toMap());
}
