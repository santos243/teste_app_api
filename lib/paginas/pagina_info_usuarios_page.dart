// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:teste_app_api/models/usuario.dart';

class PaginaDetalhesUsuario extends StatefulWidget {
  PaginaDetalhesUsuario({super.key, required this.itemLista});
  Usuario itemLista;

  @override
  State<PaginaDetalhesUsuario> createState() => _PaginaDetalhesUsuarioState();
}

class _PaginaDetalhesUsuarioState extends State<PaginaDetalhesUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Info usuario ${widget.itemLista.nome}',
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/8423/8423785.png',
                width: 300,
                height: 290,
                fit: BoxFit.fitHeight,
                color: Colors.blueAccent.shade400,
              ),
            ),
            Text(
              '\n\n\tID do usuario: ${widget.itemLista.idUsuario}'
              '\n\tNome completo do usuario: ${widget.itemLista.nome} '
              '\n\tCPF: ${widget.itemLista.cpf}\n',
              textScaleFactor: 1.5,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
