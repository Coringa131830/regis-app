import 'package:flutter/material.dart';
import 'package:smart_pantry/animation/fade_animation.dart';
import 'package:smart_pantry/pages/api_response.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/pages/login/login_bloc.dart';
import 'package:smart_pantry/pages/login/login_page.dart';
import 'package:smart_pantry/utils/alert.dart';
import 'package:smart_pantry/utils/nav.dart';

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _tConfirm = TextEditingController();

  final _bloc = LoginBloc();

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
                    "Criar conta",
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
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: "Confirmar senha",
                                        hintText: "Confirme sua senha",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                      controller: _tConfirm,
                                      validator: _validateConfirm,
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
                                  onPressed: _createAccount,
                                  child: Center(
                                    child: snapshot.data
                                        ? CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              Colors.white,
                                            ),
                                          )
                                        : Text(
                                            "Criar",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
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
                            child: Text("Já tem uma conta?", style: TextStyle(
                              fontSize: 18
                            ),),
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

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return "Confirme a sua senha";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Confirme a sua senha";
    }
    return null;
  }

  String _validateConfirm(String text) {
    if (text.isEmpty) {
      return "Confirme a sua senha";
    }
    return null;
  }

  _createAccount() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String email = _tLogin.text;
    String senha = _tSenha.text;
    String confirm = _tConfirm.text;

    if (senha == confirm) {
      ApiResponse response = await _bloc.create(email, senha);

      if (response.ok) {
        ApiResponse loginResponse = await _bloc.login(email, senha);

        if (loginResponse.ok) {
          push(context, InitialPage(), replace: true);
        } else {
          alert(context,
              "Não foi possível fazer o login.\nVolte para a tela inicial e tente novamente!",
              callback: () {
            pop(context);
          });
        }
      } else {
        alert(context, response.msg);
      }
    } else {
      alert(context,
          "As senhas não correspondem.\nPor favor, verifique os valores digitados e tente novamente");
    }
  }
}
