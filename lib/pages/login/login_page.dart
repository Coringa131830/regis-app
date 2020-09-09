import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_pantry/pages/home/home_page.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/pages/login/usuario.dart';
import 'package:smart_pantry/utils/alert.dart';
import 'package:smart_pantry/utils/nav.dart';
import 'package:smart_pantry/widgets/app_button.dart';
import 'package:smart_pantry/widgets/app_text.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();

    Future<Usuario> future = Usuario.get();

    future.then((Usuario user) {
      if (user != null)
        setState(() {
          _tLogin.text = user.email;
        });
    });
  }

  final _formKey = GlobalKey<FormState>();

  bool _showProgress = false;

  final _tLogin = TextEditingController();

  final _tSenha = TextEditingController();

  final _focusSenha = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text("Login"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  SizedBox(height: 30),
                  AppText(
                    "Digite seu email",
                    "",
                    validator: (s) => _validateLogin(s),
                    controller: _tLogin,
                    nextFocus: _focusSenha,
                    keyboardType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20),
                  AppText(
                    "Digite sua senha",
                    "",
                    validator: (s) => _validateSenha(s),
                    controller: _tSenha,
                    focusNode: _focusSenha,
                    keyboardType: TextInputType.text,
                    inputAction: TextInputAction.done,
                    password: true,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Esqueci a senha",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: AppButton(
                        "CONTINUAR",
                        onPressed: _signInWithEmailAndPassword,
                        showprogress: _showProgress,
                      )),
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
      return "Digite o e-mail";
    }
    return null;
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return "Digite a sua senha";
    }
    return null;
  }

  void _signInWithEmailAndPassword() async {
    if (!_formKey.currentState.validate()) {
      return;
    }


    setState(() {
      _showProgress = true;
    });


    final User fUser = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(
      email: _tLogin.text,
      password: _tSenha.text,
    )
            .catchError(() {
              setState(() {
                _showProgress = false;
              });
      alert(context, "Não foi possível fazer o login, tente novamente!");
    }))
        .user;

    // Cria um usuario do app
    final user = Usuario(
        nome: fUser.displayName, email: fUser.email, foto: fUser.photoURL);
    user.save();

    setState(() {
      _showProgress = false;
    });


    if (user != null) {
      push(context, InitialPage(), replace: true);
    } else {
      alert(context, "Não foi possível fazer o login, tente novamente!");
    }
  }
}
