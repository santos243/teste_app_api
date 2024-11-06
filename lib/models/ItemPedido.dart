import 'dart:convert';

import 'package:teste_app_api/models/i_model.dart';
import 'package:teste_app_api/models/produto.dart';

class ItemPedido extends IModel {
  final int? idItemPedido;
  Produto produto;
  int quantidade;

  ItemPedido(
      {this.idItemPedido, required this.produto, required this.quantidade});

  factory ItemPedido.fromMap(Map<String, dynamic> map) {
    return ItemPedido(
        idItemPedido: map['idItemPedido'] as int?,
        produto: map['produto'] as Produto,
        quantidade: map['quantidade'] as int);
  }

  factory ItemPedido.fromJson(String source) =>
      ItemPedido.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idItemPedido': idItemPedido,
      'produto': produto,
      'quantidade': quantidade
    };
  }

  Produto setProduto(Produto produtoInput) {
    produto = produtoInput;
    return produto;
  }

  @override
  fromMap(Map<String, dynamic> map) {
    ItemPedido.fromMap(map);
  }
}
