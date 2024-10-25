import 'package:flutter/material.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_user_page.dart';
import 'package:teste_app_api/paginas/pagina_inicial_page.dart';

class PaginaCadastroUsuarioEfetuadoPage extends StatefulWidget {
  const PaginaCadastroUsuarioEfetuadoPage({super.key});

  @override
  State<PaginaCadastroUsuarioEfetuadoPage> createState() =>
      _PaginaCadastroUsuarioEfetuadoPageState();
}

class _PaginaCadastroUsuarioEfetuadoPageState
    extends State<PaginaCadastroUsuarioEfetuadoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Voltar"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Usuário cadastrado com sucesso!",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () => irParaTelaIncial(),
              child: const Text("Voltar para tela inicial"),
            ),
            ElevatedButton(
              onPressed: () => irParaCadastroUsuario(),
              child: const Text("Efetuar novo cadastro"),
            ),
          ],
        ),
      ),
    );
  }

  void irParaCadastroUsuario() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PaginaCadastrarUserPage(),
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
