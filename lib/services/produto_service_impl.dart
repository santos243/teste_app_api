import 'package:teste_app_api/exceptions/CategoriaCaracteresException.dart';
import 'package:teste_app_api/exceptions/SemNomeException.dart';
import 'package:teste_app_api/interface/i_produto_service.dart';
import 'package:teste_app_api/interface/I_my_http_dart.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/models/produto.dart';

class ProdutoServiceImpl implements IProdutoService {
  final IMyHttpDart iMyHttp;

  ProdutoServiceImpl(this.iMyHttp);
  final httpProdutoService = getIt<IMyHttpDart>();

  @override
  Future<void> funcaoCadastroProduto(
      {required String nome, required String categoria, required String valor}) async {
    final p = Produto(
        idProduto: 1,
        nome: nome,
        categoria: categoria,
        valor: double.tryParse(valor) ?? 0);

    // valida se os campos estão preenchidos corretamente
    if (p.nome.length < 2 || p.nome == '') {
      throw SemNomeException(
          'Campo nome não obedece os padrões pré-estabelecidos', 300);
    }
    if (p.categoria.length > 20) {
      throw CategoriaCaracteresException(
          'Campo categoria excedeu o limite de caracteres', 304);
    }
    if (p.categoria.length < 2) {
      throw CategoriaCaracteresException(
          'Campo categoria não atingiu o minimo de caracteres necesssarios',
          304);
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
