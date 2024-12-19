import 'package:teste_app_api/interface/usuario_repository.dart';
import 'package:teste_app_api/exceptions/CpfInvalidoException.dart';
import 'package:teste_app_api/exceptions/SemNomeException.dart';
import 'package:teste_app_api/interface/i_usuario_service.dart';
import 'package:teste_app_api/models/usuario.dart';

class UsuarioServiceImpl implements IUsuarioService {
  final UsuarioRepository usuarioRepository;

  UsuarioServiceImpl(this.usuarioRepository);

  // @override
  // retorna um usuario pelo id(ainda não está em uso)
  // Future<Usuario> funcaoBuscarUsuarioPorId({required int idUsuario}) async {
  //   final usuarios = await usuarioRepository.get(
  //       entity: 'usuario', builder: Usuario.fromMap);
  //   return usuarios.firstWhere((u) => u.idUsuario == idUsuario);
  // }

  @override
  // cadastra usuario
  Future<Usuario> funcaoCadastroUsuario(
      {required String nome, required String cpf}) async {
    final u = Usuario(idUsuario: 0, nome: nome, cpf: cpf);
    if (u.nome == "" || u.nome.isEmpty) {
      // criar exception
      throw SemNomeException('Campo de nome incorreto ou invalido', 300);
    }
    if (u.cpf.length != 11) {
      throw CpfInvalidoException('O cpf deve conter apenas 11 numeros', 305);
    }
    usuarioRepository.post(usuario: u);
    return u;
  }

  @override
  // deleta o usuario do banco pelo id
  Future<void> funcaoDeleteUsuario({required int idUsuario}) async {
    try {
      await usuarioRepository.delete(id: idUsuario);
    } catch (e) {
      print(
          'Erro ao deletar usuario do banco, talvez não exista ou o código esteja se perdendo no tipo de requisição');
    }
  }

  @override
  // retorna uma lista de usuarios do banco
  Future<List<Usuario>> funcaoMostrarUsuarios() async {
    return await usuarioRepository.getAll();
  }

  // não utilizado
  @override
  Future<Usuario> funcaoBuscarUsuarioPorId({required int idUsuario}) async {
    final u = await usuarioRepository.getAll();
    return u.firstWhere((usuario) => usuario.idUsuario == idUsuario);
  }
}
