// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:teste_app_api/models/ItemPedido.dart';
import 'package:teste_app_api/models/pedido.dart';
import 'package:teste_app_api/models/produto.dart';

class PaginaInfoPedidoPage extends StatefulWidget {
  PaginaInfoPedidoPage({super.key, required this.pedido});

  Pedido pedido;

  @override
  State<PaginaInfoPedidoPage> createState() => _PaginaInfoPedidoPageState();
}

class _PaginaInfoPedidoPageState extends State<PaginaInfoPedidoPage> {
  @override
  Widget build(BuildContext context) {
    var produtos = (widget.pedido.itens).map((p) => p.produto).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Pedido de ${widget.pedido.usuario!.nome}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
                'https://cdn-icons-png.flaticon.com/512/4718/4718464.png',
                scale: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Cód. Pedido: ${widget.pedido.idPedido}",
                style: const TextStyle(color: Colors.white),
                textScaler: TextScaler.linear(1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Qtd. de Produtos: ${widget.pedido.itens.length}",
                style: TextStyle(color: Colors.white),
                textScaler: TextScaler.linear(1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Produtos pedidos:",
                style: TextStyle(color: Colors.white),
                textScaler: TextScaler.linear(1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                " ",
                style: TextStyle(color: Colors.white),
                textScaler: TextScaler.linear(1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
