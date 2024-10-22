// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teste_app_api/models/i_model.dart';

typedef ModelBuilder<T> = T Function(Map<String, dynamic> map);

class MyHttpService<T extends IModel> {
  static const String URL = '192.168.0.236:8080';

  Future<List<T>> get(
      {required String entity, required ModelBuilder<T> builder}) async {
    final lista = <T>[];
    final result = await http.get(_getUri(entity: entity));

    final jsonResposta = json.decode(result.body);

    // Percorre a lista do json
    for (final itemResposta in jsonResposta) {
      final x = builder(itemResposta);

      lista.add(x);
    }

    return lista;
  }

  Future<void> post({required T model, required String entity}) async {
    final body = model.toMap();

    final response = await http.post(
      _getUri(entity: entity),
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 400) {
      throw Exception("Campo invalido ou nao preenchido.");
    } else if (response.statusCode == 200) {
      throw Exception("Cadastro efetuado com sucesso!");
    } else if (response.statusCode == 500) {
      throw Exception(
          "Ops, parece que nosso servidor está passando por manutenções, tente novamente mais tarde.");
    } else if (response.statusCode == 405) {
      throw Exception(
          "Ops! Parece que o serviço está fora do ar temporariamente, tente novamente mais tarde.");
    }
  }

  Uri _getUri({String? entity}) {
    if (entity == null) {
      return Uri.http(URL);
    }
    return Uri.http(URL, entity);
  }
}
