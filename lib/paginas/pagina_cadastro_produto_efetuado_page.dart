import 'package:flutter/material.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_produto_page.dart';
import 'package:teste_app_api/paginas/pagina_inicial_page.dart';

class PaginaCadastroProdutoEfetuadoPage extends StatefulWidget {
  const PaginaCadastroProdutoEfetuadoPage({super.key});

  @override
  State<PaginaCadastroProdutoEfetuadoPage> createState() =>
      _PaginaCadastroProdutoEfetuadoPageState();
}

class _PaginaCadastroProdutoEfetuadoPageState
    extends State<PaginaCadastroProdutoEfetuadoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voltar"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Produto cadastrado com sucesso!",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () => irParaTelaIncial(),
              child: const Text("Voltar para tela inicial"),
            ),
            ElevatedButton(
              onPressed: () => irParaCadastroProduto(),
              child: const Text("Efetuar novo cadastro"),
            ),
          ],
        ),
      ),
    );
  }

  void irParaCadastroProduto() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PaginaCadastrarProdutoPage(),
      ),
    );
  }

  void irParaTelaIncial() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PaginaInicialPage(),
      ),
    );
  }
}
