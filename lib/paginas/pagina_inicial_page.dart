// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/produto.dart';
import 'package:teste_app_api/models/usuario.dart';

class PaginaInicialPage extends StatefulWidget {
  const PaginaInicialPage({super.key});

  @override
  State<PaginaInicialPage> createState() => _PaginaInicialPageState();
}

class _PaginaInicialPageState extends State<PaginaInicialPage> {
  final listaUsuarios = <Usuario>[];
  final listaProdutos = <Produto>[];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste API'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: funcaoMostrarUsuarios,
              child: const Text('Mostrar usuarios'),
            ),
            Expanded(
              child: ListView(
                // children: [
                //   Text('Abcdef'),
                //   Text('Abcdef'),
                //   Text('Abcdef'),
                // ],
                children: listaUsuarios
                    .map(
                      (itemLista) => Row(
                        children: [
                          const FlutterLogo(
                            size: 80,
                          ),
                          // Image.network(src)
                          Expanded(
                            child: ListTile(
                              title: Text(itemLista.nome),
                              subtitle: Text(
                                  '${itemLista.id_usuario} - ${itemLista.cpf}'),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.alarm),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void funcaoMostrarUsuarios() async {

//limpa lista
    listaUsuarios.clear();

    final myHttp = MyHttpService<Usuario>();

    final xlistaUsuarios = await  myHttp.get(entity: 'usuario', builder: Usuario.fromMap);

    listaUsuarios.addAll(xlistaUsuarios);

    setState(() {});
  }

  void funcaoMostrarProdutos() async {
    var url = Uri.http('192.168.0.236:8080', 'produtos');
    var response = await http.post(url, body: {'': 'doodle', 'color': 'blue'});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }
}
