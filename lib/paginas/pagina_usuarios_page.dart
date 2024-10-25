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
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(31, 0, 0, 0),
        title: const Text(
          'Requisição de usuários',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => funcaoMostrarUsuarios(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade400),
                  child: const Text(
                    'Mostrar usuarios',
                    style: TextStyle(color: Colors.white),
                    textScaler: TextScaler.linear(1.2),
                  ),
                ),
                // const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: irParaCadastroUsuarios,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade400),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Cadastrar',
                        style: TextStyle(color: Colors.white),
                        textScaler: TextScaler.linear(1.2),
                      ),
                      Icon(
                        Icons.person_add,
                        color: Colors.white,
                      )
                    ],
                  ),
                  // child: const Text(
                  //   'Cadastrar novo usuario',
                  //   style: TextStyle(color: Colors.white),
                  //   textScaler: TextScaler.linear(1.2),
                  // ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                                title: Text(
                                  itemLista.nome,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'ID do usuario - ${itemLista.id_usuario}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // Para ajustar o tamanho corretamente
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          mostrarDetalhes(itemLista),
                                      icon: const Icon(
                                        Icons.info_outline_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // Aqui você pode adicionar outros botões se necessário
                                    IconButton(
                                      onPressed: () async =>
                                          await deleteUser(itemLista),
                                      icon: const Icon(Icons.delete_outline,
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

  // busca os usuarios no banco
  Future<void> funcaoMostrarUsuarios() async {
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

  Future<void> deleteUser(itemLista) async {
    final myHttp = MyHttpService<Usuario>();

    await myHttp.delete(entity: 'usuario', id: itemLista.id_usuario);
    await funcaoMostrarUsuarios();
  }

  void irParaCadastroUsuarios() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PaginaCadastrarUserPage()));
  }
}
