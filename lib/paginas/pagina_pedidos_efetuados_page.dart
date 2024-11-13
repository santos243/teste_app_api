import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/pedido.dart';
import 'package:teste_app_api/paginas/pagina_info_pedido_page.dart';

class PaginaPedidosEfetuadosPage extends StatefulWidget {
  const PaginaPedidosEfetuadosPage({super.key});

  @override
  State<PaginaPedidosEfetuadosPage> createState() =>
      _PaginaPedidosEfetuadosPageState();
}

class _PaginaPedidosEfetuadosPageState
    extends State<PaginaPedidosEfetuadosPage> {
  final listaPedidos = <Pedido>[];

  Future<void> funcaoMostrarPedidos() async {
    final myHttp = MyHttpService<Pedido>();

    final pedidosEncontrados =
        await myHttp.get(entity: 'pedido', builder: Pedido.fromMap);

    pedidosEncontrados.sort((a, b) => a.idPedido!.compareTo(b.idPedido!));

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
        title: const Text("Pedidos pendentes",
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade400),
                    child: const Text(
                      "Efetuar pedido",
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
                              "${pedido.itens.length} produtos",
                              style: const TextStyle(color: Colors.white54),
                            ),
                            leading: Image.network(
                                'https://cdn-icons-png.flaticon.com/512/4718/4718464.png'),
                            onTap: () => irParaInfoPedido(pedido),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => irParaInfoPedido(pedido),
                        icon: const Icon(
                          Icons.info_outline,
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

  void irParaInfoPedido(Pedido pedido) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => PaginaInfoPedidoPage(pedido: pedido)));
  }
}
