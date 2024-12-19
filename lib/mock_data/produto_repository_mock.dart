import 'package:teste_app_api/interface/produto_repository.dart';
import 'package:teste_app_api/mock_data/mock_data.dart';
import 'package:teste_app_api/models/produto.dart';

class ProdutoRepositoryMock implements ProdutoRepository {
  final List<Produto> _produtos = produto;

  @override
  Future<void> post(
      {required Produto produto}) async {
    _produtos.add(produto);
  }

  @override
  Future<List<Produto>> get() async {
    return _produtos;
  }

  @override
  Future<void> delete({required int idProduto}) async {
    _produtos.removeWhere((produto) => produto.idProduto == idProduto);
  }

  Future<Produto> funcaoBuscarProdutoPorId(int idProduto) async {
    return _produtos.firstWhere((p) => p.idProduto == idProduto);
  }
}
