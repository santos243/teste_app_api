import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/i_model.dart';

abstract class IMyHttpDart<T extends IModel> {
  Future<List<T>> get(
      {required String entity, required ModelBuilder<T> builder});

  Future<void> post({required T model, required String entity});
}