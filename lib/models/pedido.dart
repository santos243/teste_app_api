import 'dart:convert';

import 'package:teste_app_api/models/ItemPedido.dart';
import 'package:teste_app_api/models/i_model.dart';

class Pedido extends IModel {
  int? idPedido;
  int idUsuario;
  List<ItemPedido> itens;

  Pedido({this.idPedido, required this.idUsuario, required this.itens});

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      idPedido: map['idPedido'],
      idUsuario: map['idUsuario'],
      // aqui
      itens: map['itens'],
    );
  }

  factory Pedido.fromJson(String source) =>
      Pedido.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => jsonEncode(toMap());

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idPedido': idPedido,
      'idUsuario': idUsuario,
      'itens': itens.map((e) => e.toMap()).toList(),
    };
  }

  @override
  fromMap(Map<String, dynamic> map) {
    Pedido.fromMap(map);
  }
}
