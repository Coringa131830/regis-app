import 'package:flutter/material.dart';
import 'package:smart_pantry/animation/fade_animation.dart';
import 'package:smart_pantry/pages/api_response.dart';
import 'package:smart_pantry/pages/login/login_bloc.dart';
import 'package:smart_pantry/pages/login/login_page.dart';
import 'package:smart_pantry/utils/alert.dart';
import 'package:smart_pantry/utils/nav.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _tLogin = TextEditingController();

  final _bloc = LoginBloc();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.redAccent,
              Colors.red[700],
              Colors.red[400],
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: FadeAnimation(
                  1,
                  Text(
                    "Redefinir senha",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  )),
            ),
            SizedBox(height: 20),
            /*Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: FadeAnimation(
                1.6,
                Text(
                  "Enviaremos um link para que você possa redefinir sua senha",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),*/
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.red[200],
                                        // color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "E-mail",
                                        hintText: "Digite seu e-mail",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                      controller: _tLogin,
                                      validator: _validateLogin,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.6,
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              child: StreamBuilder<bool>(
                                  stream: _bloc.stream,
                                  initialData: false,
                                  builder: (context, snapshot) {
                                    return RaisedButton(
                                      color: Colors.red[900],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      onPressed: _sendPasswordReset,
                                      child: Center(
                                        child: snapshot.data
                                            ? CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                  Colors.white,
                                                ),
                                              )
                                            : Text(
                                                "Enviar",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold, fontSize: 20),
                                              ),
                                      ),
                                    );
                                  }),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          1.9,
                          InkWell(
                            child: Text("Lembrou sua senha?", style: TextStyle(
                                fontSize: 18
                            )),
                            onTap: () {
                              push(context, LoginPage(), replace: true);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _sendPasswordReset() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String email = _tLogin.text;

    ApiResponse response = await _bloc.reset(email);

    if (response.ok) {
      alert(context, "Um link foi enviado para seu email para redefinir sua senha", callback: (){
        pop(context);
      });
    } else {
      alert(context, response.msg);
    }
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Digite o seu e-mail";
    }
    return null;
  }
}
