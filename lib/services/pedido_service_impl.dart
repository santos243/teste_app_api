import 'package:teste_app_api/exceptions/SemIdUsuarioNoPedido.dart';
import 'package:teste_app_api/exceptions/SemItensNoPedidoException.dart';
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
    if (pedido.itens.isEmpty) {
      throw SemItensNoPedidoException(
          'erro ao cadastrar pedido pois nao foram selecionados nenhum item ',
          codErro: 300);
    }
    if (pedido.idUsuario == null) {
      throw SemIdUsuarioNoPedido(
          'Erro ao criar pedido pois id do usuario nâo foi encontrado', 304);
    }
    await httpPedidoService.post(model: pedido, entity: 'pedido');
  }

  // requisição do pedido.
  @override
  Future<List<Pedido>> funcaoMostrarPedidos() async {
    // requisição.
    final pLista =
        await httpPedidoService.get(entity: 'pedido', builder: Pedido.fromMap);
    // ordena o pedido pelo id do menor para o maior.
    pLista.sort((a, b) => a.idPedido!.compareTo(b.idPedido!));
    return pLista;
  }
}
