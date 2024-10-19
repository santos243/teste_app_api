
import 'package:flutter/material.dart';
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
            const Text('Insira o CPF do usuario aqui:'),
            TextField(
              controller: controllerCpf,
            ),
            ElevatedButton(
              onPressed: () => printarDadosDigitados(),
              child: const Text('Cadastrar usuário'),
            ),
          ],
        ),
      ),
    );
  }

  // apenas para teste
  void printarDadosDigitados(){
    print('nome: ${controllerNome.text}\n cpf: ${controllerCpf.text}');
  }



}
