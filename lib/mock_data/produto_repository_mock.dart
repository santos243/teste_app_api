import 'package:teste_app_api/interface/i_produto_service.dart';
import 'package:teste_app_api/mock_data/mock_data.dart';
import 'package:teste_app_api/models/produto.dart';

class ProdutoRepositoryMock implements IProdutoService {
  final List<Produto> _produtos = produto;

  @override
  Future<void> funcaoCadastroProduto(
      {required String nome, required String categoria, required String valor}) async {
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
  Future<Produto> funcaoBuscarProdutoPorId(int idProduto) async {
    return _produtos.firstWhere((p) => p.idProduto == idProduto);
  }
}
