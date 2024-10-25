// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names

// import 'package:flutter/material.dart';
// import 'package:teste_app_api/core/http/application/my_http.dart';
// import 'package:teste_app_api/models/usuario.dart';

// class PaginaDeletarUsuariosPage extends StatefulWidget {
//   PaginaDeletarUsuariosPage({super.key, required this.itemLista});
//   Usuario itemLista;
//   @override
//   State<PaginaDeletarUsuariosPage> createState() =>
//       _PaginaDeletarUsuariosPageState();
// }

// class _PaginaDeletarUsuariosPageState extends State<PaginaDeletarUsuariosPage> {
//   var controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return const
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Deletar usuario BETA"),
  //       centerTitle: true,
  //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
  //     ),
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text("Insira o ID do usuário"),
  //           TextField(
  //             controller: controller,
  //           ),
  //           ElevatedButton(
  //             onPressed: () {},
  //             child: const Text("Deletar"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // função delete chama o método do HTTP service que executa e devolve alguma exception
  // Future<void> funcaoDeletarUsuarios() async {
  //   final myHttp = MyHttpService<Usuario>();
  //   try {
  //     myHttp.delete(entity: 'usuario', id: int.parse(controller.text));
  //     // ignore: empty_catches
  //   } catch (Exception) {
  //     ScaffoldMessenger.maybeOf(context)?.showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           Exception.toString(),
  //         ),
  //       ),
  //     );
  //   }
  // }
// // }
// import 'package:flutter/material.dart';
// import 'package:teste_app_api/core/http/application/my_http.dart';
// import 'package:teste_app_api/models/usuario.dart';

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();

//   }
//    Future<void> funcaoDeletarUsuarios() async {
//     final myHttp = MyHttpService<Usuario>();
//     try {
//       myHttp.delete(entity: 'usuario', id: int.parse(controller.text));
//       // ignore: empty_catches
//     } catch (Exception) {
//       ScaffoldMessenger.maybeOf(context)?.showSnackBar(
//         SnackBar(
//           content: Text(
//             Exception.toString(),
//           ),
//         ),
//       );
//     }
// }
