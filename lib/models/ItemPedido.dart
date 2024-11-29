// ignore_for_file: file_names

import 'dart:convert';

import 'package:teste_app_api/models/i_model.dart';
import 'package:teste_app_api/models/produto.dart';

class ItemPedido extends IModel {
  int? idItemPedido;
  Produto? produto;
  int? idProduto;
  int quantidade;

  ItemPedido(
      {this.idProduto,
      this.produto,
      this.idItemPedido,
      required this.quantidade});

  factory ItemPedido.fromMap(Map<String, dynamic> map) {
    return ItemPedido(
      idItemPedido: map['idItemPedido'],
      produto: Produto.fromMap(map['produtoEntity']),
      quantidade: map['quantidade'],
    );
  }

  factory ItemPedido.fromJson(String source) =>
      ItemPedido.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idItemPedido': idItemPedido,
      'idProduto': idProduto,
      'quantidade': quantidade
    };
  }

  Map<String, dynamic> toMapTest() {
    return <String, dynamic>{
      'idItemPedido': idItemPedido,
      'produtoEntity': produto!.toMapTest(),
      'idProduto': idProduto,
      'quantidade': quantidade
    };
  }

  Produto? setProduto(Produto produtoInput) {
    produto = produtoInput;
    return produto;
  }

  @override
  fromMap(Map<String, dynamic> map) {
    ItemPedido.fromMap(map);
  }
}
