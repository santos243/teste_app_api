import 'package:teste_app_api/interface/i_produto_service.dart';
import 'package:teste_app_api/mock_data/mock_data.dart';
import 'package:teste_app_api/models/produto.dart';

class ProdutoServiceTest implements IProdutoService {
  final List<Produto> _produtos = produto;

  @override
  Future<void> funcaoCadastroProduto(
      String nome, String categoria, String valor) async {
    _produtos.add(Produto(
        idProduto: 0,
        nome: nome,
        categoria: categoria,
        valor: double.tryParse(valor) ?? 0));
  }

  @override
  Future<List<Produto>> funcaoMostrarProdutos() async {
    return _produtos;
  }

  @override
  Future<void> delete(int idProduto) async {
    _produtos.removeWhere((produto) => produto.idProduto == idProduto);
  }

  @override
  Future<Produto> funcaoBuscarProdutoPorId(int idProduto) {
    // TODO: implement funcaoBuscarProdutoPorId
    throw UnimplementedError();
  }
}
