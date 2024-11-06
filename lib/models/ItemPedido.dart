import 'package:teste_app_api/models/i_model.dart';
import 'package:teste_app_api/models/produto.dart';

class ItemPedido extends IModel {
  final int? idItemPedido;
  Produto produto;
  int quantidade;

  ItemPedido(
      {this.idItemPedido, required this.produto, required this.quantidade});

  @override
  Map<String, dynamic> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }

  Produto setProduto(Produto produtoInput) {
    produto = produtoInput;
    return produto;
  }
}
