import 'package:flutter/material.dart';

class ListaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset('assets/logos/mini_logo.png', width: 100,),
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
