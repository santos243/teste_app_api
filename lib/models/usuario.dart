// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:teste_app_api/models/i_model.dart';

class Usuario extends IModel {
  int id_usuario;
  String nome;
  String cpf;

  /// Construtor
  Usuario({
    required this.id_usuario,
    required this.nome,
    required this.cpf,
  });




  /// Construtor
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id_usuario: map['id_usuario'] as int,
      nome: map['nome'] as String,
      cpf: map['cpf'] as String,
    );
  }

  /// Construtor
  factory Usuario.fromJson(String source) => Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id_usuario': id_usuario,
      'nome': nome,
      'cpf': cpf,
    };
  }

  String toJson() => json.encode(toMap());


  @override
  String toString() => 'Usuario(id_usuario: $id_usuario, nome: $nome, cpf: $cpf)';

  @override
  fromMap(Map<String, dynamic> map) {
    Usuario.fromMap(map);
  }
}
