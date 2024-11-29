import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:teste_app_api/models/ItemPedido.dart';
import 'package:teste_app_api/models/pedido.dart';
import 'package:teste_app_api/models/produto.dart';
import 'package:teste_app_api/models/usuario.dart';

void main() {
  final produto = Produto(
      idProduto: 1, nome: 'Machado', categoria: 'Marcenaria', valor: 112.0);
  List<ItemPedido> itens = [
    ItemPedido(quantidade: 3, produto: produto, idItemPedido: 2, idProduto: 1)
  ];

  final usuario = Usuario(idUsuario: 1, nome: 'arnaldo', cpf: '90080070001');

  final pedido =
      Pedido(idPedido: 3, usuario: usuario, itens: itens, idUsuario: 1);

  test('Deve transformar um pedido em um mapa', () {
    var p = pedido.toMap();
    expect(p, {
      'idPedido': 3,
      'idUsuario': 1,
      'itens': [
        {
          'idItemPedido': 2,
          'idProduto': 1,
          'quantidade': 3,
        }
      ]
    });
  });
  test('Deve recuperar dados de um mapa', () {
    final json = jsonEncode(pedido.toMapTest());
    final jsonResposta = jsonDecode(json);
    final p = Pedido.fromMap(jsonResposta);
    expect(p.idPedido, pedido.idPedido);
  });
  test('description', () {});
}
