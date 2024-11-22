// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:teste_app_api/models/usuario.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_produto_page.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_user_page.dart';
import 'package:teste_app_api/paginas/pagina_pedidos_efetuados_page.dart';
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
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text(
          'Bem vindo!',
          style: TextStyle(color: Colors.white),
          textScaler: TextScaler.linear(1.5),
        ),
        backgroundColor: Colors.black12,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Colors.black,
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/512/226/226777.png",
                width: 300,
                height: 320,
                fit: BoxFit.fitWidth,
              ),
            ),
            // ElevatedButton(
            //   onPressed: irParaPedidos,
            //   style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.blueAccent.shade400),
            //   child: const Text(
            //     'Pedidos',
            //     style: TextStyle(color: Colors.white),
            //     textScaler: TextScaler.linear(1.2),
            //   ),
            // ),
            ElevatedButton(
              onPressed: irParaUsuarios,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade400),
              child: const Text(
                'Consultar usuários',
                textScaler: TextScaler.linear(1.2),
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: irParaProdutos,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade400),
              child: const Text(
                'Consultar produtos',
                textScaler: TextScaler.linear(1.2),
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: irParaCadastroUsuarios,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade400),
              child: const Text(
                'Cadastrar usuário',
                textScaler: TextScaler.linear(1.2),
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: irParaCadastroProduto,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade400),
              child: const Text(
                'Cadastrar produto',
                textScaler: TextScaler.linear(1.2),
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => irParaCadastrarPedidos(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade400),
              child: const Text(
                'Novo pedido',
                textScaler: TextScaler.linear(1.2),
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => irParaPedidosEfetuados(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade400),
              child: const Text(
                "Pedidos efetuados(experimental)",
                textScaler: TextScaler.linear(1.2),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void irParaProdutos() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => const PaginaProdutosPage(
                tipoLista: TipoLista.CONSULTA_PRODUTOS,
              )),
    );
  }

  void irParaUsuarios() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) =>
              const PaginaUsuariosPage(tipoListagem: TipoListagem.CONSULTA)),
    );
  }

  void irParaCadastrarPedidos() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => const PaginaUsuariosPage(
              tipoListagem: TipoListagem.CRIACAO_PEDIDO)),
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

  void irParaPedidosEfetuados() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PaginaPedidosEfetuadosPage()));
  }
}
