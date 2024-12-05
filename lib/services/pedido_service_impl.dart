import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/interface/I_my_http_dart.dart';
import 'package:teste_app_api/interface/i_pedido_service.dart';
import 'package:teste_app_api/models/pedido.dart';

class PedidoServiceImpl extends IPedidoService {
  final IMyHttpDart iMyHttpDart;

  PedidoServiceImpl(this.iMyHttpDart);
  final httpPedidoService = getIt<IMyHttpDart>();

  @override
  Future<void> funcaoCriarPedido({required Pedido pedido}) async {
    await httpPedidoService.post(model: pedido, entity: 'pedido');
  }

  @override
  Future<List<Pedido>> funcaoMostrarPedidos() {
    // TODO: implement funcaoMostrarPedidos
    throw UnimplementedError();
  }
}
