
import 'package:teste_app_api/models/i_model.dart';

typedef ModelBuilder<T> = T Function(Map<String, dynamic> map);

abstract class IMyHttpDart<T extends IModel> {

  Future<List<T>> get<T>(
      {required String entity, required ModelBuilder<T> builder});

  Future<void> post({required T model, required String entity});

  Future<void> delete({required String entity, required int id});
}
