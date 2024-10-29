import 'package:flutter/material.dart';
// import 'package:teste_app_api/core/http/application/my_http.dart';

class PaginasPedidosPage extends StatefulWidget {
  const PaginasPedidosPage({super.key});

  @override
  State<PaginasPedidosPage> createState() => _PaginasPedidosPageState();
}

class _PaginasPedidosPageState extends State<PaginasPedidosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Pedidos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade400),
                    child: const Text(
                      'Mostrar Pedidos',
                      style: TextStyle(color: Colors.white),
                      textScaler: TextScaler.linear(1.2),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade400),
                    child: const Text(
                      'Cadastrar Pedido',
                      style: TextStyle(color: Colors.white),
                      textScaler: TextScaler.linear(1.2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> funcaoMostrarUsuarios()async {
    // final myHttp = MyHttpService<>();
  }
}
