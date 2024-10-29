// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/produto.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_produto_page.dart';
import 'package:teste_app_api/paginas/pagina_info_produto_page.dart';

class PaginaProdutosPage extends StatefulWidget {
  const PaginaProdutosPage({super.key});

  @override
  State<PaginaProdutosPage> createState() => _PaginaProdutosPageState();
}

class _PaginaProdutosPageState extends State<PaginaProdutosPage> {
  final listaProdutos = <Produto>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Requisição de produtos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => funcaoMostrarProdutos(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade400),
                  child: const Text(
                    'Mostrar produtos',
                    style: TextStyle(color: Colors.white),
                    textScaler: TextScaler.linear(1.2),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => irParaCadastroProduto(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade400),
                  child: Text(
                    'Cadastrar produto',
                    style: TextStyle(color: Colors.white),
                    textScaler: TextScaler.linear(1.2),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: listaProdutos
                      .map(
                        (itemProduto) => Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Image.network(
                             'https://cdn-icons-png.flaticon.com/512/5902/5902522.png',
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(itemProduto.nome),
                                subtitle: Text('ID - ${itemProduto.id_produto}'),
                                subtitleTextStyle: TextStyle(color: Colors.white),
                                titleTextStyle: TextStyle(color: Colors.white),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          irParaInfoProdutos(itemProduto),
                                      icon: Icon(
                                        Icons.info_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => deleteProduto(itemProduto),
                                      icon: Icon(Icons.delete_outline_rounded,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> funcaoMostrarProdutos() async {
    listaProdutos.clear();

    final myHttp = MyHttpService<Produto>();
    final xlistaProdutos =
        await myHttp.get(entity: 'produtos', builder: Produto.fromMap);

    listaProdutos.addAll(xlistaProdutos);
    setState(() {});
  }

  Future<void> deleteProduto(itemProduto) async {
    final myHttp = MyHttpService<Produto>();

    await myHttp.delete(entity: 'produtos', id: itemProduto.id_produto);
    await funcaoMostrarProdutos();
  }

  void irParaInfoProdutos(Produto itemProduto) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => PaginaInfoProdutoPage(itemProduto: itemProduto)),
    );
  }

  void irParaCadastroProduto() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaginaCadastrarProdutoPage()),
    );
  }
}
