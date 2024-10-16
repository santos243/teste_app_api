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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Info usuario ${widget.itemLista.nome}'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              'https://cdn.pixabay.com/photo/2012/04/26/19/43/profile-42914_960_720.png',
              width: 30,
              height: 290,
              fit: BoxFit.fitHeight
              ),
            Text(
              '\n\tID do usuario: ${widget.itemLista.id_usuario}'
              '\n\tNome completo do usuario: ${widget.itemLista.nome} '
              '\n\tCPF do usuario: ${widget.itemLista.cpf}\n',
              textScaleFactor: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}
