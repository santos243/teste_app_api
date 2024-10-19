import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/produto.dart';

class PaginaCadastrarProdutoPage extends StatefulWidget {
  const PaginaCadastrarProdutoPage({super.key});

  @override
  State<PaginaCadastrarProdutoPage> createState() =>
      _PaginaCadastrarProdutoPageState();
}

class _PaginaCadastrarProdutoPageState
    extends State<PaginaCadastrarProdutoPage> {
  var controllerNome = TextEditingController();
  var controllerCategoria = TextEditingController();
  var controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar novo produto'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Insira o nome do produto:'),
            TextField(
              controller: controllerNome,
            ),
            const Text(
                'Insira qual categoria o produto pertence\n ex: Marcenaria, Eletrodoméstico, Eletrônico, etc'),
            TextField(
              controller: controllerCategoria,
            ),
            const Text('Insira o valor do produto:'),
            TextField(
              controller: controllerValor,
            ),
            ElevatedButton(
              onPressed: () async => {
                // fazer com que a exception seja lançada em uma snack bar dentro do app
                funcaoCadastroProduto(),
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> funcaoCadastroProduto() async {
    final myHttp = MyHttpService<Produto>();

    final p = Produto(
        id_produto: 1,
        nome: controllerNome.text,
        categoria: controllerCategoria.text,
        valor: double.parse(controllerValor.text));
  try{
     await myHttp.post(model: p, entity: 'produtos');
  } catch (Exception){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Campo invalido ou vazio, verifique os campos novamente!"),
          ),
      );
  }

  }
}
