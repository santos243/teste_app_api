import 'package:teste_app_api/models/usuario.dart';

abstract class UsuarioRepository {
  Future<void> post({required Usuario usuario});
  Future<List<Usuario>> getAll();
  Future<void> delete({required int id});
}
