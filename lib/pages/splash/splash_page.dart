import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/pages/login/email_page.dart';
import 'package:smart_pantry/pages/login/login_page.dart';
import 'package:smart_pantry/utils/nav.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    // Future futureUser = Usuario.get();
    Future futureDelay = Future.delayed(Duration(seconds: 3));

    Future.wait([futureDelay]).then((values) {
      // Usuario user = values[1];
      User user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        push(context, InitialPage(), replace: true);
      } else {
        push(context, EmailPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/logos/splash_logo.png')),
          SizedBox(height: 10),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
