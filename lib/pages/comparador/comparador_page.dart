import 'package:flutter/material.dart';

class ComparePage extends StatefulWidget {
  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          if (isVisible) {
            setState(() {
              isVisible = false;
            });
          } else {
            setState(() {
              isVisible = true;
            });
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/logos/mini_logo.png', width: 100,),
            SizedBox(height: 80),
            InkWell(
              child: Center(
                child: isVisible
                    ? Image.asset('assets/images/comparador.png')
                    : Container(),
              ),
              onTap: () {
                if (isVisible) {
                  setState(() {
                    isVisible = false;
                  });
                } else {
                  setState(() {
                    isVisible = true;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
