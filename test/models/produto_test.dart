import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:teste_app_api/models/produto.dart';

/// O json não tem o idProduto, serve para testar o toMap do produto.
/// O jsonTest simula uma requisição real do banco, vem com idProduto para poder fazer o fromMap do produto.

void main() {
  final p = Produto(
      idProduto: 6, nome: 'Aspirador', categoria: 'Marcenaria', valor: 199.0);
  final json = jsonEncode(p.toMap());
  final jsonTest = jsonEncode(p.toMapTest());

  final listaProdutos = <Produto>[
    Produto(
        idProduto: 1, nome: 'Machado', categoria: 'Marcenaria', valor: 112.0),
    Produto(
        idProduto: 2,
        nome: 'Serra Eletrica',
        categoria: 'Marcenaria',
        valor: 799.0),
    Produto(
        idProduto: 3,
        nome: 'Maquina de cortar grama',
        categoria: 'Marcenaria',
        valor: 1399.0),
    Produto(
        idProduto: 4, nome: 'Vassoura', categoria: 'Marcenaria', valor: 29.0),
    Produto(
        idProduto: 5,
        nome: 'Motor para Roçadeira',
        categoria: 'Marcenaria',
        valor: 799.0),
    Produto(
        idProduto: 6, nome: 'Aspirador', categoria: 'Marcenaria', valor: 199.0),
  ];

  test('Deve retornar o tamanho da lista como 6', () {
    expect(listaProdutos.length, 6);
  });

  test('deve retornar um item de uma lista de map', () {
    var listaMap = <Map>[];
    for (var element in listaProdutos) {
      var map = element.toMap();
      listaMap.add(map);
    }
    expect(listaMap.first,
        {'nome': 'Machado', 'categoria': 'Marcenaria', 'valor': 112.0});
  });

  test('Deve transformar o json para um map', () {
    final map = jsonDecode(json);
    expect(
        map, {'nome': 'Aspirador', 'categoria': 'Marcenaria', 'valor': 199.0});
  });
  test('Deve transformar um map em objeto dart', () {
    const builder = Produto.fromMap;
    final map = jsonDecode(jsonTest);
    var p = builder(map);
    expect(p.idProduto, 6);
  });

  test('description', () {});
  test('description', () {});
  test('description', () {});
}
