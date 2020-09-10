import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_pantry/firebase/firebase_service.dart';
import 'package:smart_pantry/pages/home/home_page.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/pages/login/login_page.dart';
import 'package:smart_pantry/pages/login/usuario.dart';
import 'package:smart_pantry/utils/nav.dart';
import 'package:smart_pantry/pages/blank_page.dart';
import 'package:smart_pantry/utils/prefs.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  String url_foto;

  UserAccountsDrawerHeader _header() {

    User user = FirebaseAuth.instance.currentUser;

    if (user.photoURL == null) {
      url_foto =
          "https://firebasestorage.googleapis.com/v0/b/sonhodedeus-8ebbd.appspot.com/o/Android-PNG-Pic.png?alt=media&token=664035d6-dba5-4604-929e-e3c3c3789f86";
    } else {
      url_foto = user.photoURL;
    }
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.greenAccent,
            Colors.lightBlueAccent,
          ],
        ),
      ),
      accountName: Text(
        user.displayName ?? "Nome",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      accountEmail: Text(
        user.email ?? "E-mail",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(url_foto),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            _header(),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Opção 1"),
              onTap: () {
                pop(context);
                push(context, InitialPage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Opção 2"),
              onTap: () {
                pop(context);
                push(context, BlankPage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.tasks),
              title: Text("Opção 3"),
              onTap: () {
                pop(context);
                push(context, BlankPage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text("Opção 4"),
              onTap: () {
                pop(context);
                push(context, BlankPage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.shoppingBasket),
              title: Text("Opção 5"),
              onTap: () {
                pop(context);
                push(context, BlankPage(), replace: true);
              },
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: _onClickLogout,
            ),
          ],
        ),
      ),
    );
  }

  void _onClickLogout() async {
    Prefs.setInt("idx", null);
    await FirebaseService().logout();
    push(context, LoginPage(), replace: true);
  }
}
