import 'dart:async';
import 'dart:core';

import 'package:teste_app_api/models/produto.dart';

abstract class IProdutoService {
  // cadastra produto.
  Future<void> funcaoCadastroProduto(
      {required String nome,required String categoria, required String valor});
  // retorna uma lista de produto do banco.
  Future<List<Produto>> funcaoMostrarProdutos();
  // busca produto pelo id(ainda não está sendo usado).
  Future<Produto> funcaoBuscarProdutoPorId(int idProduto);
  // deleta produto do banco pelo id.
  Future<void> delete(int idProduto);
}
