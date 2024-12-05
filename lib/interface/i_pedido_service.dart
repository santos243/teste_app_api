import 'package:teste_app_api/models/pedido.dart';

abstract class IPedidoService {

  Future<void> funcaoCriarPedido({required Pedido pedido});

  Future<List<Pedido>> funcaoMostrarPedidos();

}
