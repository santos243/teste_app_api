// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/usuario.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_user_page.dart';
import 'package:teste_app_api/paginas/pagina_info_usuarios_page.dart';
import 'package:teste_app_api/paginas/pagina_produtos_page.dart';
import 'package:teste_app_api/providers/PedidoProvider.dart';

enum TipoListagem { CONSULTA, CRIACAO_PEDIDO }

class PaginaUsuariosPage extends StatefulWidget {
  final TipoListagem tipoListagem;

  const PaginaUsuariosPage({super.key, required this.tipoListagem});

  @override
  State<PaginaUsuariosPage> createState() => _PaginaUsuariosPageState();
}

class _PaginaUsuariosPageState extends State<PaginaUsuariosPage> {
  final listaUsuarios = <Usuario>[];

  @override
  Widget build(BuildContext context) {
    final carrinhoProvider =
        Provider.of<PedidoProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(31, 0, 0, 0),
          title: widget.tipoListagem == TipoListagem.CONSULTA
              ? const Text(
                  'Usuários',
                  style: TextStyle(color: Colors.white),
                )
              : const Text(
                  'Selecione o usuário',
                  style: TextStyle(color: Colors.white),
                )),
      body: Center(
        child: FutureBuilder(
          future: funcaoMostrarUsuarios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            final usuarios = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // widget.tipoListagem == TipoListagem.CRIACAO_PEDIDO
                    //     ? const SizedBox.shrink()
                    //     :
                    // ElevatedButton(
                    //   onPressed: () => funcaoMostrarUsuarios(),
                    //   style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.blueAccent.shade400),
                    //   child: const Text(
                    //     'Mostrar usuarios',
                    //     style: TextStyle(color: Colors.white),
                    //     textScaler: TextScaler.linear(1.2),
                    //   ),
                    // ),
                    // const SizedBox(width: 10),
                    widget.tipoListagem == TipoListagem.CRIACAO_PEDIDO
                        ? const SizedBox.shrink()
                        : ElevatedButton(
                            onPressed: irParaCadastroUsuarios,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade400),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Cadastrar ',
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
                      children: usuarios!
                          .map(
                            (itemLista) => Row(
                              children: [
                                // const FlutterLogo(
                                //   size: 80,
                                // ),

                                Expanded(
                                  child: ListTile(
                                    leading: Image.network(
                                      "https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_960_720.png",
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    onTap: () {
                                      // se as condiçoes forem verdadeiras, um pedido deve se iniciar redirecionando o usuario para pagina de produtos.
                                      if (widget.tipoListagem ==
                                          TipoListagem.CRIACAO_PEDIDO) {
                                        carrinhoProvider
                                            .createPedido(itemLista.idUsuario);
                                        irParaCriacaoPedido();
                                      }
                                    },
                                    title: Text(
                                      itemLista.nome,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      'ID - ${itemLista.idUsuario}',
                                      style:
                                          const TextStyle(color: Colors.white),
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
                                        widget.tipoListagem ==
                                                TipoListagem.CRIACAO_PEDIDO
                                            ? const SizedBox.shrink()
                                            : IconButton(
                                                onPressed: () async {
                                                  await deleteUser(itemLista);
                                                },
                                                icon: const Icon(
                                                    Icons.delete_outline,
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
            );
          },
        ),
      ),
    );
  }

  // busca os usuarios no banco
  Future<List<Usuario>> funcaoMostrarUsuarios() async {
    //limpa lista
    listaUsuarios.clear();

    final myHttp = MyHttpService<Usuario>();

    // final xlistaUsuarios =

    // listaUsuarios.addAll(xlistaUsuarios);

    // setState(() {});
    return await myHttp.get(entity: 'usuario', builder: Usuario.fromMap);
  }

  mostrarDetalhes(Usuario itemLista) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => PaginaDetalhesUsuario(itemLista: itemLista)),
    );
  }

  void irParaCriacaoPedido() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const PaginaProdutosPage(tipoLista: TipoLista.CRIACAO_PED)));
  }

  Future<void> deleteUser(itemLista) async {
    final myHttp = MyHttpService<Usuario>();

    await myHttp.delete(entity: 'usuario', id: itemLista.idUsuario);
    listaUsuarios.clear();
    await funcaoMostrarUsuarios();
  }

  void irParaCadastroUsuarios() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PaginaCadastrarUserPage()));
  }
}
