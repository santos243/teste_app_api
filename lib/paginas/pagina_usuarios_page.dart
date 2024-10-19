import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/usuario.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_user_page.dart';
import 'package:teste_app_api/paginas/pagina_info_usuarios_page.dart';

class PaginaUsuariosPage extends StatefulWidget {
  const PaginaUsuariosPage({super.key});

  @override
  State<PaginaUsuariosPage> createState() => _PaginaUsuariosPageState();
}

class _PaginaUsuariosPageState extends State<PaginaUsuariosPage> {
  final listaUsuarios = <Usuario>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Requisição de usuários'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => funcaoMostrarUsuarios(),
              child: const Text('Mostrar usuarios'),
            ),
            ElevatedButton(
                onPressed: irParaCadastroUsuarios,
                child: const Text('Cadastrar novo usuario')),
            Expanded(
              child: ListView(
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
          ],
        ),
      ),
    );
  }

  // busca os usuarios no banco
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

  void irParaCadastroUsuarios() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PaginaCadastrarUserPage()));
  }
}
