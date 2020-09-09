import 'package:flutter/material.dart';

class GastosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Icon(Icons.monetization_on, size: 50,)),
          Text("Controle Page body"),
        ],
      ),
    );
  }
}
