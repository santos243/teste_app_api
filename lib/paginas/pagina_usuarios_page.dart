// ignore_for_file: constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app_api/core/http/application/my_http_service.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/interface/i_usuario_service.dart';
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
  final myHttp = getIt<IUsuarioService>();



  // busca os usuarios no banco
  Future<void> funcaoMostrarUsuarios() async {
    listaUsuarios.clear();
    final usuariosEncontrados =
        await myHttp.funcaoMostrarUsuarios();
  // organiza os usuarios pelo id(do menor pro maior)
    usuariosEncontrados.sort((a, b) => a.idUsuario.compareTo(b.idUsuario));
    listaUsuarios.addAll(usuariosEncontrados);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await funcaoMostrarUsuarios();
    });
  }

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
        child: Column(
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
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: listaUsuarios
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
                                        .createPedido(itemLista.idUsuario!);
                                    irParaCriacaoPedido();
                                  } else {
                                    mostrarDetalhes(itemLista);
                                  }
                                },
                                title: Text(
                                  itemLista.nome,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'ID - ${itemLista.idUsuario}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // Para ajustar o tamanho corretamente
                                  children: [
                                    // IconButton(
                                    //   onPressed: () =>
                                    //       mostrarDetalhes(itemLista),
                                    //   icon: const Icon(
                                    //     Icons.info_outline_rounded,
                                    //     color: Colors.white,
                                    //   ),
                                    // ),
                                    // Aqui você pode adicionar outros botões se necessário
                                    widget.tipoListagem == TipoListagem.CONSULTA
                                        ? ElevatedButton(
                                            onPressed: () => {
                                                  carrinhoProvider.createPedido(
                                                      itemLista.idUsuario),
                                                  irParaCriacaoPedido(),
                                                },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.blueAccent.shade400),
                                            child: const Text(
                                              'Fazer pedido',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.2),
                                            ))
                                        : const SizedBox.shrink(),
                                    widget.tipoListagem ==
                                            TipoListagem.CRIACAO_PEDIDO
                                        ? const SizedBox.shrink()
                                        : IconButton(
                                            onPressed: () async {
                                              await delete
                                              (itemLista);
                                              await funcaoMostrarUsuarios();
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
        ),
      ),
    );
  }

// // busca os usuarios no banco(Não está mais em uso)
//   Future<List<Usuario>> funcaoMostrarUsuarios() async {
//     //limpa lista
//     listaUsuarios.clear();

//     final myHttp = MyHttpService<Usuario>();

//     // final xlistaUsuarios =

//     // listaUsuarios.addAll(xlistaUsuarios);

//     // setState(() {});
//     return await myHttp.get(entity: 'usuario', builder: Usuario.fromMap);
//   }

  void irParaUsuariosCriarPedido() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const PaginaUsuariosPage(tipoListagem: TipoListagem.CRIACAO_PEDIDO),
      ),
    );
  }

  void mostrarDetalhes(Usuario itemLista) {
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

  /// Deleta usuário.
  Future<void> delete(Usuario itemLista) async {
    /// guarda o retorno do dialog.
    final usuarioConfirmou = await _showMyDialog();
    if (usuarioConfirmou! == true) {
      /// se o usuario confirmou, executa a deleção.
      await myHttp.funcaoDeleteUsuario(idUsuario: itemLista.idUsuario);
    }
  }

  void irParaCadastroUsuarios() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const PaginaCadastrarUserPage()));
  }

  Future<bool?> _showMyDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // o usuario precisa pressionar sim ou não.

      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const SingleChildScrollView(
            child: ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                Text('Você está prestes a excluir o usuário'),
                Text('Deseja continuar?'),
              ],
            ),
          ),
          // botões de ação
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
