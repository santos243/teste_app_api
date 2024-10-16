// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/usuario.dart';
import 'package:teste_app_api/paginas/pagina_info_usuarios_page.dart';
import 'package:teste_app_api/paginas/pagina_produtos_page.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Requisição de usuários'),
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
                          // const FlutterLogo(
                          //   size: 80,
                          // ),
                          Image.network(
                            "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_960_720.png",
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(itemLista.nome),
                              subtitle: Text(
                                  'ID do usuario - ${itemLista.id_usuario}'),
                              trailing: IconButton(
                                onPressed: () => mostrarDetalhes(itemLista),
                                icon: const Icon(Icons.info_outline_rounded),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () => irParaProdutos(),
              child: const Text('Ir para produtos'),
            ),
          ],
        ),
      ),
    );
  }

  void funcaoMostrarUsuarios() async {
    //limpa lista
    listaUsuarios.clear();

    final myHttp = MyHttpService<Usuario>();

    final xlistaUsuarios =
        await myHttp.get(entity: 'usuario', builder: Usuario.fromMap);

    listaUsuarios.addAll(xlistaUsuarios);

    setState(() {});
  }

  mostrarDetalhes(Usuario itemLista) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => PaginaDetalhesUsuario(itemLista: itemLista)),
    );
  }

  void irParaProdutos() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaginaProdutosPage()),
    );
  }

  // void funcaoMostrarProdutos() async {
  //   var url = Uri.http('192.168.0.236:8080', 'produtos');
  //   var response = await http.post(url, body: {'': 'doodle', 'color': 'blue'});
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');

  //   print(await http.read(Uri.https('example.com', 'foobar.txt')));
  // }
}
