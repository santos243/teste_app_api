// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:teste_app_api/models/i_model.dart';

class Produto extends IModel {
  int idProduto;
  String nome;
  String categoria;
  double valor;

  Produto({
    required this.idProduto,
    required this.nome,
    required this.categoria,
    required this.valor,
  });

  // Construtor
  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
        idProduto: map['idProduto'] as int,
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

  // é utilizado apenas para transformar um objeto em um mapa, para poder simular um fromMap.
  Map<String, dynamic> toMapTest() {
    return <String, dynamic>{
      'idProduto': idProduto,
      'nome': nome,
      'categoria': categoria,
      'valor': valor,
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  String toString() =>
      'Produto(id_produto: $idProduto, nome: $nome, categoria: $categoria, valor: $valor)';

  @override
  fromMap(Map<String, dynamic> map) {
    Produto.fromMap(map);
  }
}
