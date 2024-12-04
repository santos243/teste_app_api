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
  Future<void> funcaoCadastroUsuario({required String nome, required String cpf}) async {
    final u = Usuario(idUsuario: 0, nome: nome, cpf: cpf);
    return httpUsuarioService.post(model: u, entity: 'usuario');
  }

  @override
  // deleta o usuario do banco pelo id
  Future<void> funcaoDeleteUsuario({required int idUsuario}) async {
    await httpUsuarioService.delete(entity: 'usuario', id: idUsuario);
  }

  @override
  // retorna uma lista de usuarios do banco
  Future<List<Usuario>> funcaoMostrarUsuarios() async {
    return await httpUsuarioService.get(
        entity: 'usuario', builder: Usuario.fromMap);
  }
}
