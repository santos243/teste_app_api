import 'dart:convert';

import 'package:teste_app_api/models/ItemPedido.dart';
import 'package:teste_app_api/models/i_model.dart';
import 'package:teste_app_api/models/usuario.dart';

class Pedido extends IModel {
  final int? idPedido;
  final Usuario usuario;
  List<ItemPedido> itens;

  Pedido({this.idPedido, required this.usuario, required this.itens});

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
        idPedido: map['id_pedido'] as int,
        usuario: map['usuario'] as Usuario,
        itens: map['itens'] as List<ItemPedido>);
  }

  factory Pedido.fromJson(String source) =>
      Pedido.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPedido': idPedido,
      'usuario': usuario,
      'itens': itens,
    };
  }

  @override
  fromMap(Map<String, dynamic> map) {
    Pedido.fromMap(map);
  }
}
