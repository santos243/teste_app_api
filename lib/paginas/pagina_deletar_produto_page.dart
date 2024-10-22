import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
              onPressed: () => funcaoDeletarProduto(),
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
        "http://192.168.0.236:8080/delete/produtos/${int.parse(controllerId.text)}");

    await http.delete(uri);
  }

  // Future<void> funcaoDelete() async {
  //   final myHttp = MyHttpService<Produto>();

  //   final p = Produto(id_produto: int.parse(controllerId.text),categoria: "",nome: "",valor: 0);

  //   await myHttp.delete(entity: 'produtos/${p.id_produto}');
  // }
}
