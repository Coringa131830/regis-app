import 'package:flutter/material.dart';
import 'package:smart_pantry/animation/fade_animation.dart';
import 'package:smart_pantry/pages/api_response.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/pages/login/create_account_email.dart';
import 'package:smart_pantry/pages/login/forgot_password_page.dart';
import 'package:smart_pantry/pages/login/login_bloc.dart';
import 'package:smart_pantry/utils/alert.dart';
import 'package:smart_pantry/utils/nav.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _showProgress = false;

  final _bloc = LoginBloc();

  @override
  void initState() {
    super.initState();
  }

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
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  )),
            ),
            SizedBox(height: 20),
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
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Senha",
                                        hintText: "Digite sua senha",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                      controller: _tSenha,
                                      validator: _validateSenha,
                                      textInputAction: TextInputAction.done,
                                      keyboardType: TextInputType.text,
                                      obscureText: true,
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
                                  onPressed: _signInWithEmailAndPassword,
                                  child: Center(
                                    child: snapshot.data
                                        ? CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              Colors.white,
                                            ),
                                          )
                                        : Text(
                                            "Login",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                          1.9,
                          InkWell(
                            child: Text(
                              "Esqueci minha senha",
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              push(context, ForgotPasswordPage());
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        FadeAnimation(
                          1.9,
                          InkWell(
                            child: Text(
                              "Criar conta",
                              style: TextStyle(fontSize: 18),
                            ),
                            onTap: () {
                              push(context, CreateAccountEmail());
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

  String _validateLogin(text) {
    if (text.isEmpty) {
      return "Digite o login";
    }
    return null;
  }

  String _validateSenha(text) {
    if (text.isEmpty) {
      return "Digite a senha";
    }
    return null;
  }

  void _signInWithEmailAndPassword() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    /*setState(() {
        _showProgress = true;
      });
      (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _tLogin.text,
        password: _tSenha.text,
      ))
          .user;

      setState(() {
        _showProgress = false;
      });*/
    String login = _tLogin.text;
    String senha = _tSenha.text;

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      push(context, InitialPage(), replace: true);
    } else {
      alert(context,
          "Não foi possível fazer o login.\nPor favor, verifique os dados e tente novamente!");
    }
  }
}
