import 'package:teste_app_api/core/http/application/usuario_repository.dart';
import 'package:teste_app_api/interface/I_my_http_dart.dart';
import 'package:teste_app_api/models/usuario.dart';

class UsuarioRepositoryHttp implements UsuarioRepository {
  final IMyHttpDart iMyHttpDart;

  UsuarioRepositoryHttp(this.iMyHttpDart);

  @override
  Future<void> post({required Usuario usuario}) async {
    await iMyHttpDart.post(model: usuario, entity: 'usuario');
  }

  @override
  Future<List<Usuario>> getAll() async {
    return await iMyHttpDart.get(entity: 'usuario', builder: Usuario.fromMap);
  }

  @override
  Future<void> delete({required int id}) async {
    await iMyHttpDart.delete(entity: 'usuario', id: id);
  }
}
