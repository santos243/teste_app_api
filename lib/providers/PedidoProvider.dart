// ignore_for_file: prefer_final_fields, unused_field

import 'dart:collection';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:teste_app_api/models/ItemPedido.dart';
import 'package:teste_app_api/models/Pedido.dart';
import 'package:teste_app_api/models/produto.dart';

class PedidoProvider extends ChangeNotifier {
  late Pedido _pedido;

  NumberFormat format = NumberFormat("00.00");
  // var carrinho = [];
  // UnmodifiableListView<Produto> get lista => UnmodifiableListView([]);

  Pedido get pedido => _pedido;

  // Cria um objeto pedido a partir do usuario selecionado.
  void createPedido(int idUsuario) {
    // inicialmente ele inicia com a lista de itens vazia.
    _pedido = Pedido(idPedido: 1, idUsuario: idUsuario, itens: []);
    notifyListeners();
  }

  // Salva todos os item pedidos(produtos) na lista de itens dentro do pedido criado anteriormente.
  void saveAll(List<ItemPedido> itensPedido) {
    // percorre a lista do parametro, salvando cada objeto itemPedido dentro do pedido.
    for (final p in itensPedido) {
      _pedido.itens.add(p);
    }
  }

  void addItem(ItemPedido itemPedido) {
    // Tenta encontrar o item que já existe na lista
    final produtoEncontrado = _pedido.itens
        .where(
          (ip) => ip.produto == itemPedido.produto,
        )
        .firstOrNull;

    if (produtoEncontrado != null) {
      // Incrementa a quantidade se o produto já existir
      produtoEncontrado.quantidade += itemPedido.quantidade;
    } else {
      // Adiciona o item se não existir ainda na lista
      _pedido.itens.add(ItemPedido(
        idItemPedido: pedido.idPedido,
        idProduto: itemPedido.produto!.idProduto,
        quantidade: itemPedido.quantidade,
        produto: itemPedido.produto,
      ));
    }

    // Notifica os ouvintes para atualizar os widgets
    notifyListeners();
  }

  void removeItemPedido(ItemPedido itemPedido) {
    // Procura o somente o primeiro item pedido, cujo o produto tem o mesmo produto do item pedido do parametro.
    var itemPedidoEncontrado =
        _pedido.itens.firstWhere((ip) => ip.produto == itemPedido.produto);
    if (itemPedidoEncontrado.quantidade > 0) {
      // Diminui a quantidade se ela for maior que 0.
      itemPedidoEncontrado.quantidade = itemPedidoEncontrado.quantidade - 1;
    } else {
      // Se a quantidade for igual a 0 ele lança uma exception.
      throw Exception("Não foi possivel diminuir a quantidade do produto.");
    }
    // Notifica todos os ouvintes para atualizar os widgets.
    notifyListeners();
  }

  // Procura o item pedido cujo o produto tem o mesmo id do produto do parametro.
  ItemPedido? getItemPedido(Produto produto) {
    // retorno
    return _pedido.itens
        .where((ip) => ip.produto!.idProduto == produto.idProduto)
        .firstOrNull;
  }

  String getTotalValor(List<ItemPedido> itens) {
    // Inicializando uma varivel que irá acumular o valor total dos itens.
    double valorTotal = 0;
    // percorre a lista de itens, adicionando o valor * quantidade de cada item pedido à variável valorTotal.
    for (var p in itens) {
      valorTotal += p.produto!.valor * p.quantidade;
    }
    return format.format(valorTotal);
  }

  // produtos.forEach((p) => print(p.id_produto));

  // for (var i = 0; i < produtos.length; i++) {
  //   produtos[i] = _produtosAtualizados[i];
  // }

  // for (var i = 0; i < produtos.length; i++) {
  //   produtos[i] = _produtosAtualizados
  //       .firstWhere((p) => p.id_produto == produtos[i].id_produto);
  //   produtos[i] = _produtosAtualizados[i];
  // }

  // for (var produto in produtos) {
  //  produto = _produtosAtualizados.firstWhere((pa) => pa.id_produto == produto.id_produto);
  // }

  // final novosProdutos =
  // for (var produto in produtos) {

  //   produto = prod
  // }

  // print(produtos
  //     .map(
  //       (e) => e.toMap(),
  //     )
  //     .toList());
}

// Exercicio
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
