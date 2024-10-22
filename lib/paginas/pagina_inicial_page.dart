// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:teste_app_api/models/usuario.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_produto_page.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_user_page.dart';
import 'package:teste_app_api/paginas/pagina_deletar_produto_page.dart';
import 'package:teste_app_api/paginas/pagina_produtos_page.dart';
import 'package:teste_app_api/paginas/pagina_usuarios_page.dart';

class PaginaInicialPage extends StatefulWidget {
  const PaginaInicialPage({super.key});

  @override
  State<PaginaInicialPage> createState() => _PaginaInicialPageState();
}

class _PaginaInicialPageState extends State<PaginaInicialPage> {
  final listaUsuarios = <Usuario>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Página inicial'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => irParaUsuarios(),
              child: const Text('Ir para usuarios'),
            ),
            ElevatedButton(
              onPressed: () => irParaProdutos(),
              child: const Text('Ir para produtos'),
            ),
            ElevatedButton(
              onPressed: irParaCadastroUsuarios,
              child: const Text('Cadastrar novo usuarios'),
            ),
            ElevatedButton(
              onPressed: irParaCadastroProduto,
              child: const Text('Cadastrar novo produto'),
            ),
            ElevatedButton(
              onPressed: irParaDeleteProdutos,
              child: const Text("Deletar produtos"),
            ),
          ],
        ),
      ),
    );
  }

  void irParaProdutos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaginaProdutosPage()),
    );
  }

  void irParaUsuarios() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaginaUsuariosPage()),
    );
  }

  void irParaCadastroUsuarios() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PaginaCadastrarUserPage()));
  }

  void irParaCadastroProduto() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PaginaCadastrarProdutoPage()));
  }

  void irParaDeleteProdutos() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PaginaDeletarProdutoPage()));
  }

}
