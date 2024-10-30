// ignore_for_file: prefer_final_fields, unused_field

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:teste_app_api/models/produto.dart';

class CarrinhoRepositoryTeste extends ChangeNotifier {
  List<Produto> _produtosAtualizados = [
    Produto(id_produto: 3, nome: 'Maçã', categoria: 'Frutas', valor: 293),
    Produto(
        id_produto: 1,
        nome: 'Prod 2 atual',
        categoria: 'Cat 2 atual',
        valor: 30),
    Produto(
        id_produto: 4, nome: 'Bife acebolado', categoria: 'Frutas', valor: 25),
    Produto(id_produto: 2, nome: 'Tangerina', categoria: 'Frutas', valor: 2342),
  ];

  UnmodifiableListView<Produto> get lista => UnmodifiableListView([]);

  void saveAll(List<Produto> produtos) {
    // produtos.forEach((p) => print(p.id_produto));

    // for (var i = 0; i < produtos.length; i++) {
    //   produtos[i] = _produtosAtualizados[i];
    // }

    for (var i = 0; i < produtos.length; i++) {
      produtos[i] = _produtosAtualizados
          .firstWhere((p) => p.id_produto == produtos[i].id_produto);
      produtos[i] = _produtosAtualizados[i];
    }

    // for (var produto in produtos) {
    //  produto = _produtosAtualizados.firstWhere((pa) => pa.id_produto == produto.id_produto);
    // }

    // final novosProdutos =
    // for (var produto in produtos) {

    //   produto = prod
    // }

    print(produtos
        .map(
          (e) => e.toMap(),
        )
        .toList());
  }

  List<int> inteiros = [1, 2, 430, 4];

  int? getIndexValue(int valor) {
    for (var i = 0; i < inteiros.length; i++) {
      if (valor == inteiros[i]) {
        return i;
      }
    }
    return null;
  }

  int? getValueIndex(int index) {
    for (var i = 0; i < inteiros.length; i++) {
      if (i == index) {
        return inteiros[i];
      }
    }
    return null;
  }
}
