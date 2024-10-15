// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teste_app_api/models/usuario.dart';

class PaginaInicialPage extends StatefulWidget {
  const PaginaInicialPage({super.key});

  @override
  State<PaginaInicialPage> createState() => _PaginaInicialPageState();
}

class _PaginaInicialPageState extends State<PaginaInicialPage> {
  final listaUsuarios = <Usuario>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste API'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: funcaoClickBotao,
              child: const Text('Testar API'),
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

  void funcaoClickBotao() async {
    // Definindo endereço da API
    final urlApi = Uri.http('192.168.0.236:8080', 'usuario');
    // Buscando os registros na API
    final resposta = await http.get(urlApi);

    print('Response body: ${resposta.body}');
    final jsonResposta = json.decode(resposta.body);

    //limpa lista
    // listaUsuarios.clear();

    // Percorre a lista do json
    for (final itemResposta in jsonResposta) {
      // criando usuário
      // final usuario = Usuario(
      //   id_usuario: itemResposta['id_usuario'],
      //   nome: itemResposta['nome'],
      //   cpf: itemResposta['cpf'],
      // );
      final usuario = Usuario.fromMap(itemResposta);
      // add usuário na lista
      listaUsuarios.add(usuario);
    }
    setState(() {});
  }
}
