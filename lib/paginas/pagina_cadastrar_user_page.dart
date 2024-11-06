// ignore_for_file: use_build_context_synchronously,avoid_types_as_parameter_names, non_constant_identifier_names, empty_catches

import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/usuario.dart';
import 'package:teste_app_api/paginas/pagina_usuarios_page.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Cadastrar novo usuario',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Insira o nome do usuario:',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: controllerNome,
                style: const TextStyle(color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Insira o CPF do usuario aqui:\n'
                  '\t\t\t\t\t\t\t\t\t\t11 digitos',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: controllerCpf,
                style: const TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () => funcaoCadastroUsuario(),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade400),
                child: const Text(
                  'Cadastrar usuário',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
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

    if (u.nome.length < 8 || u.cpf.length != 11) {
      throw Exception(
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "CPF ou nome invalido, por favor preencha os campos corretamente."),
          ),
        ),
      );
    }

    await myHttp.post(model: u, entity: 'usuario');

    final usuarioConfirmou = await _showMyDialog();

    if (!usuarioConfirmou!) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const PaginaUsuariosPage(
            tipoListagem: TipoListagem.CONSULTA,
          ),
        ),
      );
    }

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (_) => const PaginaCadastroUsuarioEfetuadoPage()));

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

  Future<bool?> _showMyDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Usuario cadastrado com sucesso.'),
                Text('Deseja cadastrar outro usuário?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false);
                // controllerNome.clear();
                // controllerCpf.clear();
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
                controllerCpf.clear();
                controllerNome.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
