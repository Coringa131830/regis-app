import 'dart:convert' as convert;

import 'package:smart_pantry/utils/prefs.dart';

class Usuario {
  String nome;
  String sobrenome;
  String cpf;
  String email;
  String celular;
  String nascimento;
  String logradouro;
  String numero;
  String complemento;
  String bairro;
  String cep;
  String uf;
  String municipio;

  Usuario(
      {this.nome,
        this.sobrenome,
        this.cpf,
        this.email,
        this.celular,
        this.nascimento,
        this.logradouro,
        this.numero,
        this.complemento,
        this.bairro,
        this.cep,
        this.uf,
        this.municipio});

  Usuario.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    sobrenome = json['sobrenome'];
    cpf = json['cpf'];
    email = json['email'];
    celular = json['celular'];
    nascimento = json['nascimento'];
    logradouro = json['logradouro'];
    numero = json['numero'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cep = json['cep'];
    uf = json['uf'];
    municipio = json['municipio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['sobrenome'] = this.sobrenome;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['celular'] = this.celular;
    data['nascimento'] = this.nascimento;
    data['logradouro'] = this.logradouro;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    data['bairro'] = this.bairro;
    data['cep'] = this.cep;
    data['uf'] = this.uf;
    data['municipio'] = this.municipio;
    return data;
  }


  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save() {
    Map map = toJson();

    String json = convert.json.encode(map);
    Prefs.setString("user.prefs", json);
  }

  static Future<Usuario> get() async {
    String json = await Prefs.getString("user.prefs");

    if (json.isEmpty) {
      return null;
    }

    Map map = convert.json.decode(json);

    Usuario user = Usuario.fromJson(map);

    return user;
  }
}
