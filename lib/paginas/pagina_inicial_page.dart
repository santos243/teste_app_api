// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/usuario.dart';
import 'package:teste_app_api/paginas/pagina_info_usuarios_page.dart';
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
        title: const Text('Requisição de usuários'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  // void funcaoMostrarProdutos() async {
  //   var url = Uri.http('192.168.0.236:8080', 'produtos');
  //   var response = await http.post(url, body: {'': 'doodle', 'color': 'blue'});
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');

  //   print(await http.read(Uri.https('example.com', 'foobar.txt')));
  // }
}
