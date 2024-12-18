// ignore_for_file: use_build_context_synchronously,avoid_types_as_parameter_names, non_constant_identifier_names, empty_catches, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/interface/i_usuario_service.dart';
import 'package:teste_app_api/models/usuario.dart';

class PaginaCadastrarUserPage extends StatefulWidget {
  const PaginaCadastrarUserPage({super.key});

  @override
  State<PaginaCadastrarUserPage> createState() =>
      _PaginaCadastrarUserPageState();
}

class _PaginaCadastrarUserPageState extends State<PaginaCadastrarUserPage> {
  var controllerNome = TextEditingController();
  var controllerCpf = TextEditingController();
  final httpUsuarioService = getIt<IUsuarioService>();

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
                // child: Text(
                //   'Insira o nome do usuario:',
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
              widgetTextFormFieldNome(),
              // TextField(
              //   controller: controllerNome,
              //   style: const TextStyle(color: Colors.white),
              // ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                // child: Text(
                //   'Insira o CPF do usuario aqui:\n'
                //   '\t\t\t\t\t\t\t\t\t\t11 digitos',
                //   style: TextStyle(color: Colors.white),
                // ),
              ),
              widgetTextFormFieldCpf(),
              // TextField(
              //   controller: controllerCpf,
              //   style: const TextStyle(color: Colors.white),
              // ),
              ElevatedButton(
                onPressed: () async {
                  await funcaoCadastroUsuario();
                },
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

  Future<void> funcaoCadastroUsuario() async {
    /// variável usada para guardar o valor retornado no try catch, permitindo que o mesmo seja utilizado
    /// como uma condição para o dialog aparecer.
    var response;

    /// gambiarra pra poder lançar o erro em uma snackbar no app e o usuário ter consciência do que ocorreu.
    try {
      response = await httpUsuarioService.funcaoCadastroUsuario(
          nome: controllerNome.text, cpf: controllerCpf.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ocorreu um erro: $e')),
      );
    }

    /// condição para mostrar dialog.
    if (response != null) {
      await _showMyDialog();
    }
  }

  Widget widgetTextFormFieldNome() {
    return TextFormField(
      autofocus: true,
      controller: controllerNome,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        border: InputBorder.none,
        icon: Icon(
          Icons.perm_identity,
          color: Colors.white70,
        ),
        hintText: 'mín. 8 carácteres',
        hintStyle: TextStyle(color: Colors.white70),
        labelText: 'Insira o nome',
      ),
    );
  }

  Widget widgetTextFormFieldCpf() {
    return TextFormField(
      autofocus: true,
      controller: controllerCpf,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        border: InputBorder.none,
        icon: Icon(
          Icons.perm_identity,
          color: Colors.white70,
        ),
        hintText: 'máx. 11 carácteres',
        hintStyle: TextStyle(color: Colors.white70),
        labelText: 'Insira o CPF',
      ),
    );
  }

  Future<bool?> _showMyDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // o usuario precisa escolher entre sim ou não.
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
                // fecha o dialog com resultado 'falso'
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                // fecha o dialog com resultado verdadeiro
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
