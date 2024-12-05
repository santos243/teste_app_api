import 'package:flutter_test/flutter_test.dart';
import 'package:teste_app_api/core/http/application/exceptions/SemNomeException.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/interface/i_produto_service.dart';
import 'package:teste_app_api/models/produto.dart';

void main() {
  final httpProdutoService = getIt<IProdutoService>();

  test('Deve disparar uma SemNomeException()', () {
    final p =
        Produto(nome: '', categoria: 'categoria', valor: 23, idProduto: 0);
    expect(
        () => httpProdutoService.funcaoCadastroProduto(
            nome: p.nome, categoria: p.categoria, valor: p.valor.toString()),
        SemNomeException);
  });
}
