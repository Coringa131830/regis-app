import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:smart_pantry/animation/fade_animation.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/pages/notifications/notifications_page.dart';
import 'package:smart_pantry/utils/alert.dart';
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

  final _formKey = GlobalKey<FormState>();

  final cepMaskFormatter =
      new MaskTextInputFormatter(mask: '#####-###', filter: {
    "#": RegExp(r'[0-9]'),
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      var data = value.data();

      if (data != null && !data.isEmpty) {
        _tLogradouro.text = data['logradouro'] ?? "";

        _tNum.text = data['numero'] ?? "";
        _tCEP.text = data['cep'] ?? "";
        _tMunicipio.text = data['municipio'] ?? "";
        _tEstado.text = data['uf'] ?? "";
        _tBairro.text = data['bairro'] ?? "";
        _tComplemento.text = data['complemento'] ?? "";
      }
    });

    return Scaffold(
      drawer: DrawerList(colorBeginRed, colorEndYellow),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {
              push(context, NotificationsPage(), replace: true);
            },
          ),
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
      child: Form(
        key: _formKey,
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
                                  textInputAction: TextInputAction.next,
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
                                  textInputAction: TextInputAction.next,
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
                                  textInputAction: TextInputAction.next,
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
                                  textInputAction: TextInputAction.next,
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
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [cepMaskFormatter],
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
                                  textInputAction: TextInputAction.next,
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
                          SizedBox(height: 10),
                          Center(
                            child: Container(
                              width: 188,
                              height: 34,
                              child: RaisedButton(
                                onPressed: _onClickSaveUserDoc,
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
                  ),
                ],
              ),
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

  _onClickSaveUserDoc() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String uid = FirebaseAuth.instance.currentUser.uid;

    String logradouro = _tLogradouro.text;
    String numero = _tNum.text;
    String complemento = _tComplemento.text ?? "";
    String bairro = _tBairro.text;
    String cep = _tCEP.text;
    String uf = _tEstado.text;
    String municipio = _tMunicipio.text;

    /*Usuario usuario = Usuario(
      bairro: bairro,
      cep: cep,
      complemento: complemento,
      logradouro: logradouro,
      municipio: municipio,
      numero: numero,
      uf: uf,
    );*/

    final usermap = {
      "bairro": bairro,
      "cep": cep,
      "complemento": complemento,
      "logradouro": logradouro,
      "municipio": municipio,
      "numero": numero,
      "uf": uf
    };

    var doc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if(doc.exists) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update(usermap)
          .then((value) {
        alert(context, "Dados salvos com sucesso!");
        Future.delayed(Duration(seconds: 3)).then((value) {
          push(context, InitialPage(), replace: true);
        });
      }).catchError((error) {
        print("ERRO >>>>>>>>>>>>>>>> $error");
        alert(context, "Ocorreu um erro ao salvar os dados, tente novamente");
      });
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(usermap)
          .then((value) {
        alert(context, "Dados salvos com sucesso!");
        Future.delayed(Duration(seconds: 3)).then((value) {
          push(context, InitialPage(), replace: true);
        });
      }).catchError((error) {
        print("ERRO >>>>>>>>>>>>>>>> $error");
        alert(context, "Ocorreu um erro ao salvar os dados, tente novamente");
      });
    }
  }
}
