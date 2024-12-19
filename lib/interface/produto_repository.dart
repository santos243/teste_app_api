import 'package:teste_app_api/models/produto.dart';

abstract class ProdutoRepository {
  Future<void> post({required Produto produto});
  Future<List<Produto>> get();
  Future<void> delete({required int idProduto});
}
