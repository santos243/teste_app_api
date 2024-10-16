// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/produto.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Requisição de produtos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => funcaoMostrarProdutos(),
              child: const Text('Mostrar produtos'),
            ),
            Expanded(
              child: ListView(
                children: listaProdutos
                    .map(
                      (itemProduto) => Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRbj_yi1IsynZEogJoBgYAu4f8-Ox5is10wg&s',
                            height: 70,
                            width: 50,
                            fit: BoxFit.cover,
                            ),
                          Expanded(
                            child: ListTile(
                              title: Text(itemProduto.nome),
                              subtitle: Text('ID - ${itemProduto.id_produto}'),
                              trailing: IconButton(
                                onPressed: () => irParaInfoProdutos(itemProduto),
                                icon: Icon(Icons.info_outlined),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void funcaoMostrarProdutos() async {
    listaProdutos.clear();

    final myHttp = MyHttpService<Produto>();
    final xlistaProdutos =
        await myHttp.get(entity: 'produtos', builder: Produto.fromMap);

    listaProdutos.addAll(xlistaProdutos);
    setState(() {});
  }

  void irParaInfoProdutos(Produto itemProduto) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PaginaInfoProdutoPage(itemProduto: itemProduto)),
    );
  }
}
