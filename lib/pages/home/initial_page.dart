import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_pantry/pages/comparador/comparador_page.dart';
import 'package:smart_pantry/pages/despensa/despensa_page.dart';
import 'package:smart_pantry/pages/gastos/gastos_page.dart';
import 'package:smart_pantry/pages/home/home_page.dart';
import 'package:smart_pantry/pages/lista/lista_page.dart';
import 'package:smart_pantry/pages/notifications/notifications_page.dart';
import 'package:smart_pantry/utils/consts.dart';
import 'package:smart_pantry/utils/nav.dart';
import 'package:smart_pantry/utils/prefs.dart';
import 'package:smart_pantry/widgets/drawer_list.dart';

class InitialPage extends StatefulWidget {
  Color colorBegin = colorBeginRed;
  Color colorEnd = colorEndYellow;

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _currentIdx = 0;

  String title;

  final titleController = StreamController<String>();

  final colorController = StreamController<List<Color>>();

  final drawerController = BehaviorSubject<List<Color>>();

  Stream<List<Color>> get drawerStream => drawerController.stream;

  _initBar() async {
    _currentIdx = await Prefs.getInt("idx");
    title = await Prefs.getString("title");
    titleController.add(title);

    if (_currentIdx == null) {
      _currentIdx = 0;
      title = "Smart Pantry";
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initBar();
  }

  Widget CallPage(int idx) {
    Prefs.getString("title").then((titulo) => titleController.add(titulo));

    switch (idx) {
      case 0:
        Prefs.setString("title", "Smart Pantry");
        colorController.add([colorBeginRed, colorEndYellow]);
        drawerController.add([colorBeginRed, colorEndYellow]);
        Prefs.getString("title").then((titulo) => titleController.add(titulo));

        return HomePage();

        break;
      case 1:
        Prefs.setString("title", "Comparador de preços");
        widget.colorBegin = colorBeginBlue;
        widget.colorEnd = colorEndGreen;
        colorController.add([colorBeginBlue, colorEndGreen]);
        drawerController.add([colorBeginBlue, colorEndGreen]);

        Prefs.getString("title").then((titulo) => titleController.add(titulo));
        return ComparePage();
        break;
      case 2:
        Prefs.setString("title", "Lista de compras");
        colorController.add([colorBeginRed, colorEndYellow]);
        drawerController.add([colorBeginRed, colorEndYellow]);
        Prefs.getString("title").then((titulo) => titleController.add(titulo));
        return ListaPage();
        break;
      case 3:
        Prefs.setString("title", "Controle de gastos");

        colorController.add([colorBeginBlue, colorEndGreen]);
        drawerController.add([colorBeginBlue, colorEndGreen]);

        Prefs.getString("title").then((titulo) => titleController.add(titulo));
        return GastosPage();
        break;
      case 4:
        Prefs.setString("title", "Despensa");
        colorController.add([colorBeginRed, colorEndYellow]);
        drawerController.add([colorBeginRed, colorEndYellow]);
        Prefs.getString("title").then((titulo) => titleController.add(titulo));
        return DespensaPage();
        break;

      default:
        Prefs.setString("title", "Smart Pantry");
        Prefs.getString("title").then((titulo) => titleController.add(titulo));
        return HomePage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: StreamBuilder<List<Color>>(
          stream: drawerStream,
          initialData: [
            colorBeginRed,
            colorEndYellow,
          ],
          builder: (context, snapshot) {
            return DrawerList(snapshot.data[0], snapshot.data[1]);
          }),
      appBar: AppBar(
        iconTheme: new IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        title: StreamBuilder<String>(
            stream: titleController.stream,
            builder: (context, snapshot) {
              return Text(snapshot.data ?? "Smart Pantry");
            }),
        flexibleSpace: StreamBuilder<List<Color>>(
          stream: colorController.stream,
          initialData: [colorBeginRed, colorEndYellow],
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: snapshot.data),
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              push(context, NotificationsPage());
            },
          ),
        ],
      ),
      body: Container(child: CallPage(_currentIdx)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIdx,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => _setIdx(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.lightBlueAccent,
            ),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/comparador.png',
              width: 25,
              color: Colors.grey,
            ),
            activeIcon: Image.asset(
              'assets/images/comparador.png',
              width: 25,
            ),
            label: "Comparador",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/lista.png',
              width: 25,
              color: Colors.grey,
            ),
            activeIcon: Image.asset(
              'assets/images/lista.png',
              width: 25,
            ),
            label: "Lista de compras",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/gastos.png',
              width: 25,
              color: Colors.grey,
            ),
            activeIcon: Image.asset(
              'assets/images/gastos.png',
              width: 25,
            ),
            label: "Controle de gastos",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/despensa.png',
              width: 25,
              color: Colors.grey,
            ),
            activeIcon: Image.asset(
              'assets/images/despensa.png',
              width: 25,
            ),
            label: "Despensa",
          ),
        ],
      ),
    );
  }

  _setIdx(int index) async {
    setState(() {
      _currentIdx = index;
    });

    await Prefs.setInt("idx", index);
  }

  @override
  void dispose() {
    super.dispose();
    drawerController.close();
    colorController.close();
    titleController.close();
  }
}
