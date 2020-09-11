import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_pantry/pages/comparador/comparador_page.dart';
import 'package:smart_pantry/pages/despensa/despensa_page.dart';
import 'package:smart_pantry/pages/gastos/gastos_page.dart';
import 'package:smart_pantry/pages/home/home_page.dart';
import 'package:smart_pantry/pages/lista/lista_page.dart';
import 'package:smart_pantry/pages/notifications/notifications_page.dart';
import 'package:smart_pantry/utils/nav.dart';
import 'package:smart_pantry/utils/prefs.dart';
import 'package:smart_pantry/widgets/drawer_list.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  int _currentIdx = 0;

  String title;

  _initBar() async {
    _currentIdx = await Prefs.getInt("idx");

    if (_currentIdx == null) {
      _currentIdx = 0;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _initBar();
  }

  Widget CallPage(int idx) {
    switch (idx) {
      case 0:
        return HomePage();
        break;
      case 1:
        return ComparePage();
        break;
      case 2:
        return ListaPage();
        break;
      case 3:
        return GastosPage();
        break;
      case 4:
        return DespensaPage();
        break;

      default:
        return HomePage();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Smart Pantry"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.redAccent,
                Colors.orangeAccent,
              ],
            ),
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_outlined), onPressed: () {
            push(context, NotificationsPage());
          })
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
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.lightBlueAccent,
            ),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.search,
              color: Colors.lightBlueAccent,
            ),
            label: "Comparador",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.tasks,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.tasks,
              color: Colors.lightBlueAccent,
            ),
            label: "Lista de compras",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monetization_on,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.monetization_on,
              color: Colors.lightBlueAccent,
            ),
            label: "Controle de gastos",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.shoppingBasket,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              FontAwesomeIcons.shoppingBasket,
              color: Colors.lightBlueAccent,
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
}
