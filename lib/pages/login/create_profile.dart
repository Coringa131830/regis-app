import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:smart_pantry/animation/fade_animation.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/utils/alert.dart';
import 'package:smart_pantry/utils/nav.dart';

import 'usuario.dart';

class CreateProfile extends StatefulWidget {
  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {

  final _tNome = TextEditingController();

  final _tSobrenome = TextEditingController();

  final _tCPF = TextEditingController();

  final _tEmail = TextEditingController();

  final _tCelular = TextEditingController();

  final _tNascimento = TextEditingController();

  final _tLogradouro = TextEditingController();

  final _tNum = TextEditingController();

  final _tComplemento = TextEditingController();

  final _tBairro = TextEditingController();

  final _tCEP = TextEditingController();

  final _tEstado = TextEditingController();

  final _tMunicipio = TextEditingController();

  User user;

  var idadeMaskFormatter =
      new MaskTextInputFormatter(mask: '##/##/####', filter: {
    "#": RegExp(r'[0-9]'),
  });

  var phoneMaskFormatter =
      new MaskTextInputFormatter(mask: '(##) # ####-####', filter: {
    "#": RegExp(r'[0-9]'),
  });

  var cpfMaskFormatter =
      new MaskTextInputFormatter(mask: '###.###.###-##', filter: {
    "#": RegExp(r'[0-9]'),
  });

  var cepMaskFormatter = new MaskTextInputFormatter(mask: '#####-###', filter: {
    "#": RegExp(r'[0-9]'),
  });

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser;

    if (FirebaseFirestore.instance.collection("users").doc(user.uid) != null) {
      push(context, InitialPage(), replace: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.redAccent,
                Colors.orangeAccent,
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
                    user.displayName ?? "Nome",
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xff626262),
                    ),
                  ),
                  Text(user.email ?? "E-mail"),
                  Card(
                    elevation: 8,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 36,
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: FadeAnimation(
                              1.2,
                              Container(
                                width: 280,
                                child: Text(
                                  "Nome",
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
                                    hintText: "Digite seu nome",
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
                                  controller: _tNome,
                                  validator: _validateNome,
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
                                  "Sobrenome",
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
                                    hintText: "Digite seu sobrenome",
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
                                  controller: _tSobrenome,
                                  validator: _validateSobrenome,
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
                                  "CPF (opcional)",
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
                                  inputFormatters: [cpfMaskFormatter],
                                  decoration: InputDecoration(
                                    labelText: "",
                                    hintText: "Digite seu CPF",
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
                                  controller: _tCPF,
                                  validator: _validateCPF,
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
                                  "E-mail",
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
                                  controller: _tEmail,
                                  validator: _validateEmail,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
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
                                  "Celular",
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
                                  inputFormatters: [phoneMaskFormatter],
                                  decoration: InputDecoration(
                                    labelText: "",
                                    hintText: "Digite seu celular",
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
                                  controller: _tCelular,
                                  validator: _validateCelular,
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
                                  "Nascimento",
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
                                    hintText: "Digite sua data de nascimento",
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
                                  controller: _tNascimento,
                                  validator: _validateNascimento,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [idadeMaskFormatter],
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
                          /*SizedBox(height: 10),
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
                          ),*/
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateNome(String text) {
    if (text.isEmpty) {
      return "Digite seu nome";
    }
    return null;
  }

  String _validateSobrenome(String text) {
    if (text.isEmpty) {
      return "Digite seu sobrenome";
    }
    return null;
  }

  String _validateEmail(String text) {
    if (text.isEmpty) {
      return "Digite seu e-mail";
    }
    return null;
  }

  String _validateCelular(String text) {
    if (text.isEmpty) {
      return "Digite seu celular";
    }
    return null;
  }

  String _validateNascimento(String text) {
    if (text.isEmpty) {
      return "Digite sua data de nascimento";
    }
    return null;
  }

  String _validateCPF(String text) {
    return null;
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

    String uid = user.uid;

    String nome = _tNome.text;
    String sobrenome = _tSobrenome.text;
    String cpf = cpfMaskFormatter.getMaskedText() ?? "";
    String email = _tEmail.text;
    String celular = phoneMaskFormatter.getMaskedText();
    String nascimento = idadeMaskFormatter.getMaskedText();
    String logradouro = _tLogradouro.text;
    String numero = _tNum.text;
    String complemento = _tComplemento.text ?? "";
    String bairro = _tBairro.text;
    String cep = cepMaskFormatter.getMaskedText();
    String uf = _tEstado.text;
    String municipio = _tMunicipio.text;

    Usuario usuario = Usuario(
      email: email,
      bairro: bairro,
      celular: celular,
      cep: cep,
      complemento: complemento,
      cpf: cpf,
      logradouro: logradouro,
      municipio: municipio,
      nascimento: nascimento,
      nome: nome,
      numero: numero,
      sobrenome: sobrenome,
      uf: uf,
    );

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(usuario.toJson())
        .then((value) {
      alert(context, "Dados salvos com sucesso!");
      Future.delayed(Duration(seconds: 3)).then((value) {
        push(context, InitialPage(), replace: true);
      });
    }).catchError(() {
      alert(context, "Ocorreu um erro ao salvar os dados, tente novamente");
    });
  }
}
