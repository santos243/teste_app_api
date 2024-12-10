import 'package:flutter_test/flutter_test.dart';
import 'package:teste_app_api/exceptions/CategoriaCaracteresException.dart';
import 'package:teste_app_api/exceptions/SemNomeException.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/getit/setUpInjectorsTest.dart';
import 'package:teste_app_api/interface/i_produto_service.dart';
import 'package:teste_app_api/models/produto.dart';

void main() {
  setUpInjectorsTest();


  final httpProdutoService = getIt<IProdutoService>();
  final p =
      Produto(nome: 'Machado', categoria: 'categoria', valor: 23, idProduto: 0);

  test('Deve disparar uma SemNomeException()', () {
    expect(
        () => httpProdutoService.funcaoCadastroProduto(
            nome: '', categoria: p.categoria, valor: p.valor.toString()),
        throwsA(isA<SemNomeException>()));
  });

  test('Deve disparar uma CategoriaCaracteresException()', () {
    expect(
        httpProdutoService.funcaoCadastroProduto(
            nome: p.nome,
            categoria: 'CategoriaExcedidaComÊxito',
            valor: p.valor.toString()),
        throwsA(isA<CategoriaCaracteresException>()));
  });

  test(
      'Deve disparar uma CategoriaCaracteresException() mas agora por outro motivo',
      () {
    expect(
        httpProdutoService.funcaoCadastroProduto(
            nome: p.nome, categoria: 'c', valor: p.valor.toString()),
        throwsA(isA<CategoriaCaracteresException>()));
    print(CategoriaCaracteresException);
  });
}
