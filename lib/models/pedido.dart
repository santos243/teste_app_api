import 'dart:convert';

import 'package:teste_app_api/models/ItemPedido.dart';
import 'package:teste_app_api/models/i_model.dart';
import 'package:teste_app_api/models/usuario.dart';

class Pedido extends IModel {
  int? idPedido;
  Usuario? usuario;
  int? idUsuario;
  List<ItemPedido> itens;

  Pedido({this.idPedido, this.usuario, this.idUsuario, required this.itens});

  factory Pedido.fromMap(Map<String, dynamic> map) {
    return Pedido(
      idPedido: map['idPedido'] as int,
      usuario: Usuario.fromMap(map['usuario']),
      /**
       * Os itens terão que ser mapeados um por um, se o problema pesistir, é importante
       * verificar se o ItemPedido tem um fromMap de produto.
       */
      itens: (map['itens'] as List).map((p) => ItemPedido.fromMap(p)).toList(),
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
