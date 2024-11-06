import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app_api/paginas/pagina_inicial_page.dart';
import 'package:teste_app_api/repositories/PedidoProvider.dart';

// teste
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PedidoProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PaginaInicialPage(),
      ),
    );
  }
}
