import 'package:teste_app_api/core/http/application/pedido_repository.dart';
import 'package:teste_app_api/mock_data/mock_data.dart';
import 'package:teste_app_api/models/pedido.dart';

class PedidoRepositoryMock implements PedidoRepository {
  final _pedido = pedidos;

  /// Cria um pedido em um repositório mockado.
  @override
  Future<void> post({required Pedido pedido}) async {
    _pedido.add(pedido);
  }

  /// Retorna todos os pedidos do repositório mockado.
  @override
  Future<List<Pedido>> getAll() async {
    return pedidos;
  }

  /// Retorna um pedido específico do repositório mockado.
  @override
  Future<Pedido> get({required int idPedido}) async {
    final p = pedidos;
    return p.firstWhere((pedido) => pedido.idPedido == idPedido);
  }

  /// Deleta um pedido específico no repositório 
  @override
  Future<void> delete({required int idPedido}) async {
    pedidos.removeWhere((pedido) => pedido.idPedido == idPedido);
  }
}
