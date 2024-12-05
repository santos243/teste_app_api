import 'package:teste_app_api/core/http/application/exceptions/SemCpfException.dart';
import 'package:teste_app_api/core/http/application/exceptions/SemNomeException.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/interface/I_my_http_dart.dart';
import 'package:teste_app_api/interface/i_usuario_service.dart';
import 'package:teste_app_api/models/usuario.dart';

class UsuarioService implements IUsuarioService {
  final IMyHttpDart iMyHttp;

  UsuarioService(this.iMyHttp);
  final httpUsuarioService = getIt<IMyHttpDart>();

  @override
  // retorna um usuario pelo id(ainda não está em uso)
  Future<Usuario> funcaoBuscarUsuarioPorId({required int idUsuario}) async {
    final usuarios = await httpUsuarioService.get(
        entity: 'usuario', builder: Usuario.fromMap);
    return usuarios.firstWhere((u) => u.idUsuario == idUsuario);
  }

  @override
  // cadastra usuario
  Future<void> funcaoCadastroUsuario(
      {required String nome, required String cpf}) async {
    final u = Usuario(idUsuario: 0, nome: nome, cpf: cpf);
    if (u.nome == "" || u.nome.isEmpty) {
      // criar exception
      throw SemNomeException('Campo de nome incorreto ou invalido', 300);
    }
    if (u.cpf.length != 11) {
      throw SemCpfException('O cpf deve conter apenas 11 numeros', 305);
    }

    return httpUsuarioService.post(model: u, entity: 'usuario');
  }

  @override
  // deleta o usuario do banco pelo id
  Future<void> funcaoDeleteUsuario({required int idUsuario}) async {
    try {
      await httpUsuarioService.delete(entity: 'usuario', id: idUsuario);
    } catch (e) {
      print(
          'Erro ao deletar usuario do banco, talvez não exista ou o código esteja se perdendo no tipo de requisição');
    }
  }

  @override
  // retorna uma lista de usuarios do banco
  Future<List<Usuario>> funcaoMostrarUsuarios() async {
    return await httpUsuarioService.get(
        entity: 'usuario', builder: Usuario.fromMap);
  }
}
