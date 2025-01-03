import 'package:teste_app_api/interface/usuario_repository.dart';
import 'package:teste_app_api/exceptions/CpfInvalidoException.dart';
import 'package:teste_app_api/exceptions/SemNomeException.dart';
import 'package:teste_app_api/mock_data/mock_data.dart';
import 'package:teste_app_api/models/usuario.dart';

class UsuarioRepositoryMock extends UsuarioRepository {
  final List<Usuario> _usuarios = usuarios;

  // deve retornar um usuario no repository mockado salvo em memória
  Future<Usuario> funcaoBuscarUsuarioPorId({required int idUsuario}) async {
    return _usuarios.firstWhere((u) => u.idUsuario == idUsuario);
  }

  // deve cadastrar um usuario no repository mockado
  Future<void> funcaoCadastroUsuario(
      {required String nome, required String cpf}) async {
    final u = Usuario(idUsuario: 0, nome: nome, cpf: cpf);
    if (u.nome == "" || u.nome.isEmpty) {
      // criar exception
      throw SemNomeException('Campo de nome incorreto ou invalido', 300);
    }
    if (u.cpf.length != 11) {
      throw CpfInvalidoException('O cpf deve conter apenas 11 numeros', 305);
    }
    _usuarios.add(u);
  }

  Future<void> funcaoDeleteUsuario({required int idUsuario}) async {
    _usuarios.removeWhere((usuario) => usuario.idUsuario == idUsuario);
  }

  Future<List<Usuario>> funcaoMostrarUsuarios() async {
    return _usuarios;
  }

  @override
  Future<void> delete({required int id}) async {
    _usuarios.removeWhere((p) => p.idUsuario == id);
  }

  @override
  Future<List<Usuario>> getAll() async {
    return _usuarios;
  }

  @override
  Future<void> post({required Usuario usuario}) async {
    _usuarios.add(usuario);
  }
}
