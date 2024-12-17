import 'package:teste_app_api/core/http/application/pedido_repository.dart';
import 'package:teste_app_api/interface/I_my_http_dart.dart';
import 'package:teste_app_api/models/pedido.dart';

class PedidoRepositoryHttp implements PedidoRepository{
  final IMyHttpDart iMyHttpDart;

  PedidoRepositoryHttp(this.iMyHttpDart);

  /// Cria um pedido
  @override
  Future<void> post({required Pedido pedido}) async {
    await iMyHttpDart.post(model: pedido, entity: 'pedido');
  }

  /// Retorna todos os pedidos.
  @override
  Future<List<Pedido>> getAll() async {
    final pedidos = await iMyHttpDart.get(entity: 'pedido', builder: Pedido.fromMap);
    return pedidos;
  }

  /// Retorna um pedido especifico.
  @override
  Future<Pedido> get({required int idPedido}) async {
    final pedidos = await iMyHttpDart.get(entity: 'pedido', builder: Pedido.fromMap);
    return pedidos.firstWhere((pedido) => pedido.idPedido == idPedido);
  }

  /// Deleção de um pedido
  @override
  Future<void> delete({required int idPedido}) async {
    await iMyHttpDart.delete(entity: 'pedido', id: idPedido);
  }
 }