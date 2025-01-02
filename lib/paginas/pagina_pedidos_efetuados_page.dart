import 'package:flutter/material.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/interface/i_pedido_service.dart';
import 'package:teste_app_api/models/pedido.dart';
import 'package:teste_app_api/paginas/pagina_info_pedido_page.dart';
import 'package:teste_app_api/paginas/pagina_usuarios_page.dart';
import 'package:teste_app_api/providers/PedidoProvider.dart';

class PaginaPedidosEfetuadosPage extends StatefulWidget {
  const PaginaPedidosEfetuadosPage({super.key});

  @override
  State<PaginaPedidosEfetuadosPage> createState() =>
      _PaginaPedidosEfetuadosPageState();
}

class _PaginaPedidosEfetuadosPageState
    extends State<PaginaPedidosEfetuadosPage> {
  final listaPedidos = <Pedido>[];
  final pedidosRepositoryHttp = getIt<IPedidoService>();

  Future<void> funcaoMostrarPedidos() async {
    final pedidosEncontrados =
        await pedidosRepositoryHttp.funcaoMostrarPedidos();

    // pedidosEncontrados.sort((a, b) => a.idPedido!.compareTo(b.idPedido!));

    listaPedidos.addAll(pedidosEncontrados);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await funcaoMostrarPedidos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text("Pedidos Finalizados",
            textScaler: TextScaler.linear(1.1),
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => irParaEfetuarPedido(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade400),
                    child: const Text(
                      "Fazer pedido",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListView.builder(
                itemCount: listaPedidos.length,
                itemBuilder: (context, index) {
                  final pedido = listaPedidos[index];
                  return Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                              pedido.usuario!.nome,
                              style: const TextStyle(color: Colors.white),
                              textScaler: const TextScaler.linear(1.2),
                            ),
                            subtitle: Text(
                              "${pedido.itens.length} produtos - Total: R\$ ${PedidoProvider().getTotalValor(pedido.itens)}",
                              style: const TextStyle(color: Colors.white54),
                            ),
                            leading: Image.network(
                                'https://cdn-icons-png.flaticon.com/512/4718/4718464.png'),
                            onTap: () => irParaInfoPedido(pedido),
                          ),
                        ),
                      ),
                      // IconButton(
                      //   onPressed: () => irParaInfoPedido(pedido),
                      //   icon: const Icon(
                      //     Icons.info_outline,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      IconButton(
                        onPressed: () async {
                          await deletarPedido(pedido);
                          await funcaoMostrarPedidos();
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  void irParaEfetuarPedido() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const PaginaUsuariosPage(
              tipoListagem: TipoListagem.CRIACAO_PEDIDO),
        ));
  }

  void irParaInfoPedido(Pedido pedido) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PaginaInfoPedidoPage(pedido: pedido)));
  }

  /// Deleta pedido
  Future<void> deletarPedido(Pedido pedido) async {
    /// aguarda o retorno do dialog antes de executar a exclusão do pedido.
    final usuarioConfirmou = await _showMyDialog();

    if (usuarioConfirmou! == true) {
      /// se o usuario confirmou
      await pedidosRepositoryHttp.funcaoDeletarPedido(
          idPedido: pedido.idPedido!);
    }
    listaPedidos.clear();
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
                Text('Você está prestes a excluir um pedido'),
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
