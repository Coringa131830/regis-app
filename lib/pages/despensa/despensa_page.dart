import 'package:flutter/material.dart';

class DespensaPage extends StatelessWidget {
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
          Center(
            child: Image.asset('assets/images/despensa.png'),
          ),
        ],
      ),
    );
  }
}
