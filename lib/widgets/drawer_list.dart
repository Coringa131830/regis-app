import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_pantry/firebase/firebase_service.dart';
import 'package:smart_pantry/pages/blank_page.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/pages/login/login_page.dart';
import 'package:smart_pantry/pages/profile/profile_page.dart';
import 'package:smart_pantry/utils/nav.dart';
import 'package:smart_pantry/utils/prefs.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {
  String url_foto;

  UserAccountsDrawerHeader _header() {
    User user = FirebaseAuth.instance.currentUser;
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
      accountName: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          user.email ?? "E-mail",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      accountEmail: ListTile(
        tileColor: Colors.transparent,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Editar perfil",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ],
        ),
        onTap: () {
          push(context, ProfilePage());
        },
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
          user.photoURL ??
              "https://firebasestorage.googleapis.com/v0/b/sonhodedeus-8ebbd.appspot.com/o/Android-PNG-Pic.png?alt=media&token=664035d6-dba5-4604-929e-e3c3c3789f86",
        ),
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
              title: Text("Início"),
              onTap: () {
                pop(context);
                push(context, InitialPage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text("Comparador"),
              onTap: () {
                pop(context);
                push(context, BlankPage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.tasks),
              title: Text("Lista de compras"),
              onTap: () {
                pop(context);
                push(context, BlankPage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text("Controle de gastos"),
              onTap: () {
                pop(context);
                push(context, BlankPage(), replace: true);
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.shoppingBasket),
              title: Text("Despensa"),
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
