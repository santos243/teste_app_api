import 'package:teste_app_api/core/http/application/produto_repository.dart';
import 'package:teste_app_api/interface/I_my_http_dart.dart';
import 'package:teste_app_api/models/produto.dart';

class ProdutoRepositoryHttp implements ProdutoRepository {
  final IMyHttpDart iMyHttpDart;

  ProdutoRepositoryHttp(this.iMyHttpDart);

  @override
  Future<void> delete({required int idProduto}) async {
    await iMyHttpDart.delete(entity: 'produtos', id: idProduto);
  }

  @override
  Future<List<Produto>> get() async {
    return await iMyHttpDart.get(
        entity: 'produtos', builder: Produto.fromMap);
  }

  @override
  Future<void> post({required Produto produto}) async {
    await iMyHttpDart.post(model: produto, entity: 'produtos');
  }
}
