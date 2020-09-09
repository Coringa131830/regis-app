import 'package:flutter/material.dart';
import 'package:smart_pantry/widgets/drawer_list.dart';

class BlankPage extends StatelessWidget {
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
          IconButton(icon: Icon(Icons.notifications_outlined), onPressed: () {})
        ],
      ),
        body: _body(),
     );
  }

  _body() {

    return Container(
      child: Center(
        child: Text("Blank Page"),
      ),
    );
  }
}
