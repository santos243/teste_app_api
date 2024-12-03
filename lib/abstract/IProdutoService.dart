import 'dart:async';
import 'dart:core';

import 'package:teste_app_api/models/produto.dart';

abstract class IProdutoService {
  Future<void> funcaoCadastroProduto(
      String nome, String categoria, String valor);

      Future<List<Produto>> funcaoMostrarProdutos();
}
