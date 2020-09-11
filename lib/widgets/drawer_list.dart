import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_pantry/firebase/firebase_service.dart';
import 'package:smart_pantry/pages/conta/atualizar_conta.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/pages/login/email_page.dart';
import 'package:smart_pantry/pages/profile/profile_page.dart';
import 'package:smart_pantry/utils/nav.dart';
import 'package:smart_pantry/utils/prefs.dart';

class DrawerList extends StatefulWidget {
  Color colorBegin;
  Color colorEnd;

  DrawerList(this.colorBegin, this.colorEnd);

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
            widget.colorBegin,
            widget.colorEnd,
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
          push(context, ProfilePage(), replace: true);
        },
      ),
      /*currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
          user.photoURL ??
              "https://firebasestorage.googleapis.com/v0/b/sonhodedeus-8ebbd.appspot.com/o/Android-PNG-Pic.png?alt=media&token=664035d6-dba5-4604-929e-e3c3c3789f86",
        ),
      ),*/
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
              leading: Icon(Icons.person),
              title: Text("Atualizar conta"),
              onTap: () {
                Prefs.setInt("idx", 0);
                pop(context);
                push(context, AtualizarContaPage(), replace: true);
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/icons/home.png',
                width: 36,
                color: Colors.black,
              ),
              title: Text("Início"),
              onTap: () {
                Prefs.setInt("idx", 0);
                Prefs.setString("title", "Smart Pantry");
                pop(context);
                push(context, InitialPage(), replace: true);
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/icons/comparador.png',
                width: 36,
                color: Colors.black,
              ),
              title: Text("Comparador"),
              onTap: () {
                Prefs.setString("title", "Comparador de preços");
                Prefs.setInt("idx", 1);
                pop(context);
                push(context, InitialPage(), replace: true);
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/icons/lista.png',
                width: 36,
                color: Colors.black,
              ),
              title: Text("Lista de compras"),
              onTap: () {
                Prefs.setString("title", "Lista de compras");
                Prefs.setInt("idx", 2);
                pop(context);
                push(context, InitialPage(), replace: true);
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/icons/gastos.png',
                width: 36,
                color: Colors.black,
              ),
              title: Text("Controle de gastos"),
              onTap: () {
                Prefs.setString("title", "Controle de gastos");
                Prefs.setInt("idx", 3);
                pop(context);
                push(context, InitialPage(), replace: true);
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/icons/despensa.png',
                width: 36,
                color: Colors.black,
              ),
              title: Text("Despensa"),
              onTap: () {
                Prefs.setString("title", "Despensa");
                Prefs.setInt("idx", 4);
                pop(context);
                push(context, InitialPage(), replace: true);
              },
            ),
            ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
              ),
              title: Text("Logout"),
              onTap: _onClickLogout,
            ),
          ],
        ),
      ),
    );
  }

  void _onClickLogout() async {
    pop(context);
    Prefs.setInt("idx", null);
    await FirebaseService().logout();
    push(context, EmailPage(), replace: true);
  }
}
