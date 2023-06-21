import 'dart:convert';

String dataString = '''
[{
  "name": "Benelhedi",
  "vorname": "Ayssar",
  "grund": "1",
  "von": "21..1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"
},
{
  "name": "A",
  "vorname": "B",
  "grund": "1",
  "von": "21..1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"

},
{
  "name": "A",
  "vorname": "B",
  "grund": "2",
  "von": "21..1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"

},
{
  "name": "B",
  "vorname": "B",
  "grund": "1",
  "von": "21..1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"

},
{
  "name": "C",
  "vorname": "B",
  "grund": "1",
  "von": "21..1995",
  "bis": "21.09.1995",
  "beschreibung" : "K.a"

}
]
''';

List<dynamic> data = jsonDecode(dataString);
