import 'package:teste_app_api/abstract/IProdutoService.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/produto.dart';

class AuthProdutoService implements IProdutoService {
  final myHttp = MyHttpService<Produto>();
  final lista = [];

  @override
  Future<void> funcaoCadastroProduto(String nome, String categoria, String valor) async {
    final p = Produto(
        idProduto: 1,
        nome: nome,
        categoria: categoria,
        valor: double.tryParse(valor) ?? 0);


    // valida se os campos estão preenchidos corretamente
    if (p.nome.length < 2 ||
        p.categoria.length > 20 || p.categoria.length < 2) {
      throw Exception();
    }

    myHttp.post(model: p, entity: 'produtos');
  }

  @override
  Future<List<Produto>> funcaoMostrarProdutos() async {
    return [];
  }

}
