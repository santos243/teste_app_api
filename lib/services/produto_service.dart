import 'package:teste_app_api/interface/i_produto_service.dart';
import 'package:teste_app_api/interface/I_my_http_dart.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/models/produto.dart';

class ProdutoService implements IProdutoService {
  final IMyHttpDart iMyHttp;

  ProdutoService(this.iMyHttp);
  final httpProdutoService = getIt<IMyHttpDart>();

  @override
  Future<void> funcaoCadastroProduto(
      String nome, String categoria, String valor) async {
    final p = Produto(
        idProduto: 1,
        nome: nome,
        categoria: categoria,
        valor: double.tryParse(valor) ?? 0);

    // valida se os campos estão preenchidos corretamente
    if (p.nome.length < 2 ||
        p.categoria.length > 20 ||
        p.categoria.length < 2) {
      throw Exception();
    }

    await httpProdutoService.post(model: p, entity: 'produtos');
  }

  @override
  Future<List<Produto>> funcaoMostrarProdutos() async {
    final response = await httpProdutoService.get(
        entity: 'produtos', builder: Produto.fromMap);
    return response;
  }

  @override
  Future<void> delete(int idProduto) async {
    await httpProdutoService.delete(entity: 'produtos', id: idProduto);
  }

  @override
  Future<Produto> funcaoBuscarProdutoPorId(int idProduto) async {
    final produtos = await httpProdutoService.get(
        entity: 'produtos', builder: Produto.fromMap);
    return produtos.firstWhere((p) => p.idProduto == idProduto);
  }
}
