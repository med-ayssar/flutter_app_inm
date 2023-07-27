import 'package:flutter/material.dart';
import 'package:inm_6/pages/done.dart';
import 'package:inm_6/pages/new_entry.dart';
import 'package:inm_6/pages/people.dart';
import 'package:inm_6/pages/settings.dart';
import 'package:inm_6/pages/todo.dart';
import 'package:inm_6/panel.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:inm_6/data/data.dart' as database;
import 'package:inm_6/utils/observable.dart' as ob;
import 'package:provider/provider.dart';
import 'package:inm_6/utils/config.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() async {
  await ensureConfigInitialized();
  await setConfigData();
  runApp(
    Phoenix(
      child: MainApp(),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await DesktopWindow.setMinWindowSize(const Size(1600, 800));
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedPage = 0;
  final List<Widget> pages = <Widget>[
    Entry(),
    TODO(),
    Done(),
    People(),
    Settings(
      data: connectionConfig,
    )
  ];

  void updatePage(int newSelectedPage) {
    setState(() {
      selectedPage = newSelectedPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    Panel panel = Panel(selectedPage: selectedPage, setPage: updatePage);
    Widget page = pages.elementAt(selectedPage);
    return MaterialApp(
        home: ChangeNotifierProvider(
      create: (context) => ob.DataFetched(),
      child: Main(page: page, panel: panel),
    ));
  }
}

class Main extends StatefulWidget {
  final Panel panel;
  final Widget page;

  const Main({super.key, required this.page, required this.panel});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
  }

  Widget getCurrentView(ob.Status status, BuildContext context) {
    if (status == ob.Status.OK) {
      return ChangeNotifierProvider(
        create: (context) => database.observableNames,
        child: Scaffold(
            body: Row(
          children: [widget.panel, widget.page],
        )),
      );
    } else if (status == ob.Status.INIT) {
      return Center(
          child: LoadingAnimationWidget.fourRotatingDots(
        color: Colors.blueGrey,
        size: 200,
      ));
    } else {
      return const ErrorPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = context.watch<ob.DataFetched>();
    if (state.isDataFetched == ob.Status.INIT) {
      state.fechData();
    }
    Widget widget = getCurrentView(state.isDataFetched, context);
    return widget;
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xffd8f3dc),
      body: Stack(
        children: [
          Positioned(
            top: 150,
            bottom: 0,
            left: 24,
            right: 24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '404',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50,
                      letterSpacing: 2,
                      color: Color(0xff2f3640),
                      fontFamily: 'Anton',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Sorry, cannot establish connection with the database server!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff2f3640),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
