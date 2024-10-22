// ignore_for_file: use_build_context_synchronously, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/produto.dart';
import 'package:teste_app_api/paginas/pagina_cadastro_produto_efetuado_page.dart';

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
            const Text(
                'Insira o valor do produto: \n\t\t\t\t\t\tminimo 1,00 real'),
            TextField(
              controller: controllerValor,
            ),
            ElevatedButton(
              onPressed: () => funcaoCadastroProduto(),
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

    if (p.nome.length < 2 ||
        p.categoria.length > 20 && p.categoria.length < 2 ||
        p.valor < 1) {
      throw Exception(
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Verifique se os campos foram digitados corretamente e tente novamente"),
          ),
        ),
      );
    }

    try {
      await myHttp.post(model: p, entity: 'produtos');
    } catch (Exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Exception.toString()),
        ),
      );
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PaginaCadastroProdutoEfetuadoPage(),
      ),
    );
  }
}
