import 'package:flutter/material.dart';
import 'package:smart_pantry/animation/fade_animation.dart';
import 'package:smart_pantry/pages/login/create_account_email.dart';
import 'package:smart_pantry/pages/login/forgot_password_page.dart';
import 'package:smart_pantry/pages/login/senha_page.dart';
import 'package:smart_pantry/utils/nav.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final _tLogin = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Center(
                    child: FadeAnimation(
                      1.2,
                      Center(
                        child: Image.asset('assets/logos/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: FadeAnimation(
                      1.2,
                      Container(
                        width: 280,
                        child: Text(
                          "IDENTIFICAÇÃO",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: FadeAnimation(
                      1.5,
                      Container(
                        width: 280,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "",
                            hintText: "Digite seu e-mail",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            )),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                          ),
                          controller: _tLogin,
                          validator: _validateLogin,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: FadeAnimation(
                      1.5,
                      Container(
                        height: 50,
                        width: 280,
                        child: RaisedButton(
                          color: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17),
                          ),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            String email = _tLogin.text;
                            push(context, SenhaPage(email));
                          },
                          child: Text(
                            "CONTINUAR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FadeAnimation(
                    1.6,
                    Container(
                      width: 300,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            push(context, ForgotPasswordPage(), replace: true);
                          },
                          child: Text(
                            "Esqueci minha senha",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  FadeAnimation(
                    1.6,
                    Container(
                      width: 300,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            push(context, CreateAccountEmail(), replace: true);
                          },
                          child: Text(
                            "Criar conta",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite seu e-mail";
    } else {
      return null;
    }
  }
}
