import 'package:flutter/material.dart';
import 'package:smart_pantry/utils/consts.dart';
import 'package:smart_pantry/widgets/drawer_list.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(colorBeginRed, colorEndYellow),
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
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/logos/mini_logo.png', width: 100,),
          SizedBox(height: 50),
          Center(
            child: Image.asset('assets/images/notifications.png'),
          ),
        ],
      ),
    );
  }
}
