import 'dart:convert' as convert;

import 'package:smart_pantry/utils/prefs.dart';

class Usuario {
  String nome;
  String email;
  String telefone;
  String senha;
  String cpf;
  int carteira;
  String foto;
  String token;
  EndParaEntrega endParaEntrega;
  bool ativo;

  Usuario(
      {this.nome,
        this.email,
        this.telefone,
        this.senha,
        this.cpf,
        this.carteira,
        this.foto,
        this.token,
        this.endParaEntrega,
        this.ativo});

  Usuario.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    email = json['email'];
    telefone = json['telefone'];
    senha = json['senha'];
    cpf = json['cpf'];
    carteira = json['carteira'];
    foto = json['foto'];
    token = json['token'];
    endParaEntrega = json['endParaEntrega'] != null
        ? new EndParaEntrega.fromJson(json['endParaEntrega'])
        : null;
    ativo = json['ativo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['telefone'] = this.telefone;
    data['senha'] = this.senha;
    data['cpf'] = this.cpf;
    data['carteira'] = this.carteira;
    data['foto'] = this.foto;
    data['token'] = this.token;
    if (this.endParaEntrega != null) {
      data['endParaEntrega'] = this.endParaEntrega.toJson();
    }
    data['ativo'] = this.ativo;
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

    if(json.isEmpty) {
      return null;
    }

    Map map = convert.json.decode(json);

    Usuario user = Usuario.fromJson(map);

    return user;
  }
}

class EndParaEntrega {
  String cep;
  String estado;
  String cidade;
  String endereco;
  String numero;
  String complemento;

  EndParaEntrega(
      {this.cep,
        this.estado,
        this.cidade,
        this.endereco,
        this.numero,
        this.complemento});

  EndParaEntrega.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    estado = json['estado'];
    cidade = json['cidade'];
    endereco = json['endereco'];
    numero = json['numero'];
    complemento = json['complemento'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = this.cep;
    data['estado'] = this.estado;
    data['cidade'] = this.cidade;
    data['endereco'] = this.endereco;
    data['numero'] = this.numero;
    data['complemento'] = this.complemento;
    return data;
  }
}
