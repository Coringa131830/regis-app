import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String text;

  Function onPressed;
  bool showprogress;

  AppButton(this.text, {this.onPressed, this.showprogress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 50,
      child: RaisedButton(
        onPressed: onPressed,
        child: showprogress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Colors.white,
                  ),
                ),
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
        color: Colors.orangeAccent,
        //Color(0xff5AC8AE),
        textColor: Color(0xffFFFFFF),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
