// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:teste_app_api/models/produto.dart';

class PaginaInfoProdutoPage extends StatefulWidget {
  PaginaInfoProdutoPage({super.key, required this.itemProduto});

  Produto itemProduto;

  @override
  State<PaginaInfoProdutoPage> createState() => _PaginaInfoProdutoPageState();
}

class _PaginaInfoProdutoPageState extends State<PaginaInfoProdutoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Info ID ${widget.itemProduto.idProduto}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/5902/5902522.png',
                width: 230,
                height: 250,
              ),
            ),
            Text(
              '\n\tID do produto: ${widget.itemProduto.idProduto}\n'
              '\tNome do produto: ${widget.itemProduto.nome}\n'
              '\tCategoria: ${widget.itemProduto.categoria}\n'
              '\n\n\tValor unitário: R\$ ${widget.itemProduto.valor}',
              textScaleFactor: 1.5,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
