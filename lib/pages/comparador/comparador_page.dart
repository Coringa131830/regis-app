import 'package:flutter/material.dart';

class ComparePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Icon(Icons.search, size: 50,)),
          Text("Comparador Page body"),
        ],
      ),
    );
  }
}
