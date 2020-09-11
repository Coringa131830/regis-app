import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_pantry/animation/fade_animation.dart';
import 'package:smart_pantry/pages/notifications/notifications_page.dart';
import 'package:smart_pantry/utils/consts.dart';
import 'package:smart_pantry/utils/nav.dart';
import 'package:smart_pantry/widgets/drawer_list.dart';

class AtualizarContaPage extends StatefulWidget {
  @override
  _AtualizarContaPageState createState() => _AtualizarContaPageState();
}

class _AtualizarContaPageState extends State<AtualizarContaPage> {
  final _tLogradouro = TextEditingController();

  final _tNum = TextEditingController();

  final _tComplemento = TextEditingController();

  final _tBairro = TextEditingController();

  final _tCEP = TextEditingController();

  final _tEstado = TextEditingController();

  final _tMunicipio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(colorBeginRed, colorEndYellow),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.notifications_outlined),
              onPressed: () {
                push(context, NotificationsPage(), replace: true);
              })
        ],
        title: Text("Atualização da conta"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                colorBeginRed,
                colorEndYellow,
              ],
            ),
          ),
        ),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SingleChildScrollView(
        child: Center(
          child: FadeAnimation(
            1.4,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Nome",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xff626262),
                  ),
                ),
                Text(FirebaseAuth.instance.currentUser.email ?? "E-mail"),
                Card(
                  elevation: 8,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Endereço"),
                        SizedBox(height: 10),
                        Container(
                          width: 145,
                          height: 22,
                          child: RaisedButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.white,
                              size: 14,
                            ),
                            label: Text(
                              "Localização",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Color(0xffEC3329),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: FadeAnimation(
                            1.2,
                            Container(
                              width: 280,
                              child: Text(
                                "Logradouro",
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
                                  hintText: "Digite o logradouro",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                controller: _tLogradouro,
                                validator: _validateLogradouro,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                              ),
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
                                "Número",
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
                                  hintText: "Digite o número",
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
                                controller: _tNum,
                                validator: _validateNum,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                              ),
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
                                "Complemento",
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
                                  hintText: "Digite o complemento",
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
                                controller: _tComplemento,
                                validator: _validateComplemento,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                              ),
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
                                "Bairro",
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
                                  hintText: "Digite o bairro",
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
                                controller: _tBairro,
                                validator: _validateBairro,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                              ),
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
                                "CEP",
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
                                  hintText: "Digite o CEP",
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
                                controller: _tCEP,
                                validator: _validateCEP,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                              ),
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
                                "Estado / UF",
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
                                  hintText: "Digite o estado",
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
                                controller: _tEstado,
                                validator: _validateEstado,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                              ),
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
                                "Município",
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
                                  hintText: "Digite o município",
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
                                controller: _tMunicipio,
                                validator: _validateMunicipio,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 188,
                            height: 34,
                            child: RaisedButton(
                              onPressed: () {},
                              child: Center(
                                child: Text(
                                  "CONFIRMAR",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              color: Color(0xffEC3329),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _validateLogradouro(String text) {
    if (text.isEmpty) {
      return "Digite o logradouro";
    }
    return null;
  }

  String _validateNum(String text) {
    if (text.isEmpty) {
      return "Digite o número";
    }
    return null;
  }

  String _validateBairro(String text) {
    if (text.isEmpty) {
      return "Digite o bairro";
    }
    return null;
  }

  String _validateCEP(String text) {
    if (text.isEmpty) {
      return "Digite o CEP";
    }
    return null;
  }

  String _validateEstado(String text) {
    if (text.isEmpty) {
      return "Digite o estado / UF";
    }
    return null;
  }

  String _validateMunicipio(String text) {
    if (text.isEmpty) {
      return "Digite o município";
    }
    return null;
  }

  String _validateComplemento(String text) {
    return null;
  }
}
