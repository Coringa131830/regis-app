import 'dart:convert' as convert;

import 'package:smart_pantry/utils/prefs.dart';

class Usuario {
  String nome;
  String email;
  String telefone;
  String senha;
  String cpf;
  String foto;

  Usuario(
      {this.nome, this.email, this.telefone, this.senha, this.cpf, this.foto});

  Usuario.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    telefone = json['telefone'];
    senha = json['senha'];
    cpf = json['cpf'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['senha'] = this.senha;
    data['cpf'] = this.cpf;
    data['foto'] = this.foto;

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
