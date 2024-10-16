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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Info ID ${widget.itemProduto.id_produto}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRbj_yi1IsynZEogJoBgYAu4f8-Ox5is10wg&s',
              width: 50,
              height: 250,
            ),
            Text('\n\tID do produto: ${widget.itemProduto.id_produto}\n'
                '\tNome do produto: ${widget.itemProduto.nome}\n'
                '\tCategoria: ${widget.itemProduto.categoria}\n'
                '\n\n\tValor: ${widget.itemProduto.valor} reais', textScaleFactor: 1.5),
          ],
        ),
      ),
    );
  }
}
