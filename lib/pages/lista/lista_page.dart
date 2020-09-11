import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/logos/logo_mini.png'),
          SizedBox(height: 80),
          Row(
            children: [
              SizedBox(width: 125),
              Center(child: Image.asset('assets/images/lista.png')),
            ],
          ),
        ],
      ),
    );
  }
}
