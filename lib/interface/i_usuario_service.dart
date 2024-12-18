
import 'package:teste_app_api/models/usuario.dart';

abstract class IUsuarioService {
  // retorna uma lista de usuarios do banco.
  Future<List<Usuario>> funcaoMostrarUsuarios();
  // retorna um usuario pelo id(ainda não está em uso).
  Future<Usuario> funcaoBuscarUsuarioPorId({required int idUsuario});
  // deleta o usuario do banco pelo id.
  Future<void> funcaoDeleteUsuario({required int idUsuario});
  // cadastra usuario.
  Future<Usuario?> funcaoCadastroUsuario({required String nome, required String cpf});
}
