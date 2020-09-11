import 'package:flutter/material.dart';
import 'package:smart_pantry/utils/nav.dart';
import 'package:smart_pantry/widgets/drawer_list.dart';

import 'notifications/notifications_page.dart';

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
          IconButton(
              icon: Icon(Icons.notifications_outlined),
              onPressed: () {
                push(context, NotificationsPage());
              })
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
