// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/produto.dart';

class PaginaDeletarProdutoPage extends StatefulWidget {
  const PaginaDeletarProdutoPage({super.key});

  @override
  State<PaginaDeletarProdutoPage> createState() =>
      _PaginaDeletarProdutoPageState();
}

class _PaginaDeletarProdutoPageState extends State<PaginaDeletarProdutoPage> {
  var controllerId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Deletar produto"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Insira o id do produto:"),
            TextField(
              controller: controllerId,
            ),
            ElevatedButton(
              onPressed: () => funcaoDelete(),
              child: const Text("Deletar"),
            ),
          ],
        ),
      ),
    );
  }

// teste
  void printarDadosDigitados() {
    print(controllerId.text);
  }

  Future<void> funcaoDeletarProduto() async {
    final uri = Uri.parse(
        "http://192.168.0.236:8080/delete/produtos/${controllerId.text}");

    await http.delete(uri);
  }

  Future<void> funcaoDelete() async {
    final myHttp = MyHttpService<Produto>();

    try {
      await myHttp.delete(entity: 'produtos', id: int.parse(controllerId.text));
    } catch (Exception) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(Exception.toString()),
        ),
      );
    }
    controllerId.clear();
  }
}
