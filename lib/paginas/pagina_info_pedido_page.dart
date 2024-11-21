// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:teste_app_api/models/pedido.dart';
import 'package:teste_app_api/providers/PedidoProvider.dart';

class PaginaInfoPedidoPage extends StatefulWidget {
  PaginaInfoPedidoPage({super.key, required this.pedido});

  Pedido pedido;

  @override
  State<PaginaInfoPedidoPage> createState() => _PaginaInfoPedidoPageState();
}

class _PaginaInfoPedidoPageState extends State<PaginaInfoPedidoPage> {
  @override
  Widget build(BuildContext context) {
    widget.pedido.itens.sort((a, b) => b.quantidade.compareTo(a.quantidade));

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
                'https://cdn-icons-png.flaticon.com/512/4718/4718464.png',
                scale: 2),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "ID pedido: ${widget.pedido.idPedido}",
                style: const TextStyle(color: Colors.yellow),
                textScaler: TextScaler.linear(1.3),
              ),
            ),
            Text(
              'ID usuário: ${widget.pedido.usuario!.idUsuario}',
              style: const TextStyle(color: Colors.yellow),
              textScaler: TextScaler.linear(1.3),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Qtd. de Produtos: ${widget.pedido.itens.length}",
                style: TextStyle(color: Colors.yellow),
                textScaler: TextScaler.linear(1.3),
              ),
            ),
            SizedBox(
              height: 400,
              width: 400,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.pedido.itens.length,
                  itemBuilder: (context, int index) {
                    final produto = widget.pedido.itens[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(
                            produto.produto!.nome,
                            style: TextStyle(color: Colors.white),
                            textScaler: TextScaler.linear(1.4),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Center(
                                child: Text(
                                  '   ${produto.quantidade}x',
                                  style: TextStyle(color: Colors.white),
                                  textScaler: TextScaler.linear(1.3),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Valor total do pedido:",
                  style: TextStyle(color: Colors.white),
                  textScaler: TextScaler.linear(1.5),
                ),
              ),
            ),
            Text(
              'R\$ ${PedidoProvider().getTotalValor(widget.pedido.itens)}',
              style: TextStyle(color: Colors.white),
              textScaler: TextScaler.linear(2),
            ),
          ],
        ),
      ),
    );
  }
}
