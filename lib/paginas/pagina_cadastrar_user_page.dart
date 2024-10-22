// ignore_for_file: use_build_context_synchronously,avoid_types_as_parameter_names, non_constant_identifier_names, empty_catches

import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/usuario.dart';
import 'package:teste_app_api/paginas/pagina_cadastro_usuario_efetuado_page.dart';
// import 'package:http/http.dart' as http;

class PaginaCadastrarUserPage extends StatefulWidget {
  const PaginaCadastrarUserPage({super.key});

  @override
  State<PaginaCadastrarUserPage> createState() =>
      _PaginaCadastrarUserPageState();
}

class _PaginaCadastrarUserPageState extends State<PaginaCadastrarUserPage> {
  var controllerNome = TextEditingController();
  var controllerCpf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar novo usuario'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Insira o nome do usuario:'),
            TextField(
              controller: controllerNome,
            ),
            const Text('Insira o CPF do usuario aqui:\n'
            '\t\t\t\t\t\t\t\t\t\t11 digitos'),
            TextField(
              controller: controllerCpf,
            ),
            ElevatedButton(
              onPressed: () => funcaoCadastroUsuario(),
              child: const Text('Cadastrar usuário'),
            ),
          ],
        ),
      ),
    );
  }

  // apenas para teste
  // void printarDadosDigitados() {
  //   print('nome: ${controllerNome.text}\n cpf: ${controllerCpf.text}');
  // }

  Future<void> funcaoCadastroUsuario() async {
    final myHttp = MyHttpService<Usuario>();

    final u = Usuario(
        id_usuario: 1, nome: controllerNome.text, cpf: controllerCpf.text);

    if (u.nome.length < 8 || u.cpf.length < 11 || u.cpf.length > 11) {
      throw Exception(
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "CPF ou nome invalido, por favor preencha os campos corretamente."),
          ),
        ),
      );
    }

    try {
      await myHttp.post(model: u, entity: 'usuario');
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
            builder: (_) => const PaginaCadastroUsuarioEfetuadoPage()));

    // lança um aviso de usuario cadastrado se os dados não forem vazios.
    // if (u.nome.isNotEmpty && u.cpf.isNotEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("Usuário adicionado com sucesso no banco de dados"),
    //     ),
    //   );
    //   controllerCpf.clear();
    //   controllerNome.clear();
    // } else if (u.nome.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("O campo de nome está vazio."),
    //     ),
    //   );
    // } else if (u.cpf.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text("O campo de CPF está vazio"),
    //     ),
    //   );
    // }
  }
}
