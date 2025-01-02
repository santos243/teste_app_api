import 'package:teste_app_api/core/http/application/pedido_repository.dart';
import 'package:teste_app_api/exceptions/SemIdUsuarioNoPedido.dart';
import 'package:teste_app_api/exceptions/SemItensNoPedidoException.dart';
import 'package:teste_app_api/interface/i_pedido_service.dart';
import 'package:teste_app_api/models/pedido.dart';

class PedidoServiceImpl extends IPedidoService {
  final PedidoRepository pedidoRepository;

  PedidoServiceImpl(this.pedidoRepository);

  /// Cria um pedido no banco
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
    await pedidoRepository.post(pedido: pedido);
  }

  /// Retorna todos os pedidos do banco.
  @override
  Future<List<Pedido>> funcaoMostrarPedidos() async {
    /// requisição.
    final pLista = await pedidoRepository.getAll();
    /// ordena o pedido pelo id do menor para o maior.
    // pLista.sort((a, b) => a.idPedido!.compareTo(b.idPedido!));
    return pLista;
  }

  @override
  Future<void> funcaoDeletarPedido({required int idPedido}) async {
    await pedidoRepository.delete(idPedido: idPedido);
  }
}
