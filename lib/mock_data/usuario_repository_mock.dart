import 'package:teste_app_api/core/http/application/usuario_repository.dart';
import 'package:teste_app_api/mock_data/mock_data.dart';
import 'package:teste_app_api/models/usuario.dart';

class UsuarioRepositoryMock extends UsuarioRepository {
  final List<Usuario> _usuarios = usuarios;

  @override
  Future<void> post({required Usuario usuario}) async {
    _usuarios.add(usuario);
  }

  @override
  Future<List<Usuario>> getAll() async {
    return _usuarios;
  }

  @override
  Future<void> delete({required int id}) async {
    _usuarios.removeWhere((p) => p.idUsuario == id);
  }

  // deve retornar um usuario no repository mockado salvo em memória
  Future<Usuario> funcaoBuscarUsuarioPorId({required int idUsuario}) async {
    return _usuarios.firstWhere((u) => u.idUsuario == idUsuario);
  }
}
