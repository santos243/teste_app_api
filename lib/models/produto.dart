// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:teste_app_api/models/i_model.dart';

class Produto extends IModel {
  final int id_produto;
  final String nome;
  final String categoria;
  final double valor;

  Produto({
    required this.id_produto,
    required this.nome,
    required this.categoria,
    required this.valor,
  });

  // Construtor
  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
        id_produto: map['id_produto'] as int,
        nome: map['nome'] as String,
        categoria: map['categoria'] as String,
        valor: map['valor'] as double);
  }

  // Construtor
  factory Produto.fromJson(String source) =>
      Produto.fromMap(json.decode(source) as Map<String, dynamic>);

@override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{

      'nome': nome,
      'categoria': categoria,
      'valor': valor,
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  String toString() =>
      'Produto(id_produto: $id_produto, nome: $nome, categoria: $categoria, valor: $valor)';

  @override
  fromMap(Map<String, dynamic> map) {
    Produto.fromMap(map);
  }

}
