// ignore_for_file: constant_identifier_names, depend_on_referenced_packages

import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:teste_app_api/models/i_model.dart';

typedef ModelBuilder<T> = T Function(Map<String, dynamic> map);

class MyHttpService<T extends IModel> {
  static const String URL = '192.168.0.236:8080';

  // retorna uma lista de T(qualquer coisa que herda IModel).
  Future<List<T>> get(
      {required String entity, required ModelBuilder<T> builder}) async {
    // instanciando uma lista de T(qualquer coisa que extends IModel).
    final lista = <T>[];
    final result = await http.get(_getUri(path: entity));

    final jsonResposta = json.decode(result.body);

    // Percorre a lista do json
    for (final itemResposta in jsonResposta) {
      final t = builder(itemResposta);
      lista.add(t);
    }

    return lista;
  }

  Future<void> post({required T model, required String entity}) async {
    final body = model.toMap();
    final json = jsonEncode(body);

    final response = await http.post(
      _getUri(path: entity),
      body: json,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 400) {
      throw Exception("Campo invalido ou nao preenchido.");
    } else if (response.statusCode == 500) {
      throw Exception("incompatibilidade ou configuração incorreta.");
    } else if (response.statusCode == 405) {
      throw Exception(
          "Ops! Parece que o serviço está fora do ar temporariamente, tente novamente mais tarde.");
    }
  }

  Future<void> delete({required String entity, required int id}) async {
    final path = p.join(entity, id.toString());

    final response = await http.delete(_getUri(path: path));
    if (response.statusCode == 400) {
      throw Exception("Campo invalido ou não preenchido.");
    } else if (response.statusCode == 500) {
      throw Exception(
          "Ops, parece que nosso servidor está passando por manutenções, tente novamente mais tarde.");
    }
  }

  Uri _getUri({String? path}) {
    if (path == null) {
      return Uri.http(URL);
    }

    return Uri.http(URL, path);
  }
}
