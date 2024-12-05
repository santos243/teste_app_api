// ignore_for_file: constant_identifier_names, depend_on_referenced_packages, avoid_shadowing_type_parameters

import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:teste_app_api/interface/I_my_http_dart.dart';
import 'package:teste_app_api/models/i_model.dart';

typedef ModelBuilder<T> = T Function(Map<String, dynamic> map);

class MyHttpService<T extends IModel> extends IMyHttpDart<T> {
  static const String URL = '192.168.0.236:8080';

  // retorna uma lista de T(qualquer coisa que herda IModel).
  @override
  Future<List<T>> get<T>(
      {required String entity, required ModelBuilder<T> builder}) async {
    // instanciando uma lista de T(qualquer coisa que extends IModel).
    final lista = <T>[];
    final result = await http.get(_getUri(path: entity));

    // de json para map
    final jsonResposta = json.decode(result.body);

    // Percorre a lista do json
    for (final itemResposta in jsonResposta) {
      // de map para objeto Dart
      final t = builder(itemResposta);
      // adiciona os objetos dentro da lista
      lista.add(t);
    }
    // retorna essa lista
    return lista;
  }

  @override
  Future<void> post({required T model, required String entity}) async {
    // model T para um mapa
    final typeModel = model;
    final body = typeModel.toMap();
    // mapa para json
    final json = jsonEncode(body);
    // requisição
    final response = await http.post(
      _getUri(path: entity),
      body: json,
      headers: {
        "Content-Type": "application/json",
      },
    );
    // caso ocorra algum erro na requisiçao
    if (response.statusCode == 400) {
      throw Exception("Campo invalido ou nao preenchido.");
    } else if (response.statusCode == 500) {
      throw Exception("incompatibilidade ou configuração incorreta.");
    } else if (response.statusCode == 405) {
      throw Exception(
          "Ops! Parece que o serviço está fora do ar temporariamente, tente novamente mais tarde.");
    }
  }

  @override
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
