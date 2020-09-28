import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:smart_pantry/animation/fade_animation.dart';
import 'package:smart_pantry/pages/home/initial_page.dart';
import 'package:smart_pantry/pages/login/usuario.dart';
import 'package:smart_pantry/pages/notifications/notifications_page.dart';
import 'package:smart_pantry/utils/alert.dart';
import 'package:smart_pantry/utils/consts.dart';
import 'package:smart_pantry/utils/nav.dart';
import 'package:smart_pantry/widgets/drawer_list.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _tNome = TextEditingController();

  final _tSobrenome = TextEditingController();

  final _tCPF = TextEditingController();

  final _tEmail = TextEditingController();

  final _tCelular = TextEditingController();

  final _tNascimento = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get()
        .then((value) {
      var data = value.data();

      if(data != null && !data.isEmpty) {
        _tNome.text = data['nome'] ?? "";

        _tSobrenome.text = data['sobrenome'] ?? "";
        _tCPF.text = data['cpf'] ?? "";
        _tEmail.text = data['email'] ?? "";
        _tCelular.text = data['celular'] ?? "";
        _tNascimento.text = data['nascimento'] ?? "";
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

  _onClickSaveUserDoc() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String uid = FirebaseAuth.instance.currentUser.uid;

    String nome = _tNome.text;
    String sobrenome = _tSobrenome.text;
    String cpf = cpfMaskFormatter.getMaskedText() ?? "";
    String email = _tEmail.text;
    String celular = phoneMaskFormatter.getMaskedText();
    String nascimento = idadeMaskFormatter.getMaskedText();

    Usuario usuario = Usuario(
      email: email,
      celular: celular,
      cpf: cpf,
      nascimento: nascimento,
      nome: nome,
      sobrenome: sobrenome,
    );

    final userMap = {
      "email": email,
      "celular": celular,
      "cpf": cpf,
      "nascimento": nascimento,
      "nome": nome,
      "sobrenome": sobrenome,
    };

    var doc = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if(doc.exists) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update(userMap)
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
          .set(userMap)
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
