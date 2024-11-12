// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:teste_app_api/models/i_model.dart';

class Usuario extends IModel {
  int idUsuario;
  String nome;
  String cpf;

  /// Construtor
  Usuario({
    required this.idUsuario,
    required this.nome,
    required this.cpf,
  });

  /// Construtor
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      idUsuario: map['idUsuario'] as int,
      nome: map['nome'] as String,
      cpf: map['cpf'] as String,
    );
  }

  /// Construtor
  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idUsuario': idUsuario,
      'nome': nome,
      'cpf': cpf,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Usuario(idUsuario: $idUsuario, nome: $nome, cpf: $cpf)';

  @override
  fromMap(Map<String, dynamic> map) {
    Usuario.fromMap(map);
  }
}
