import 'package:teste_app_api/models/pedido.dart';

abstract class PedidoRepository {

  Future<void> post({required Pedido pedido});

  Future<List<Pedido>> getAll();

  Future<void> delete({required int idPedido});

  Future<Pedido> get({required int idPedido});

}
