import 'package:flutter/material.dart';
import 'package:smart_pantry/widgets/drawer_list.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),
      appBar: AppBar(
        title: Text("Smart Pantry"),
        centerTitle: true,
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
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: Center(
        child: Text("Editar Perfil"),
      ),
    );
  }
}
