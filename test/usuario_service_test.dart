import 'package:flutter_test/flutter_test.dart';
import 'package:teste_app_api/exceptions/CpfInvalidoException.dart';
import 'package:teste_app_api/exceptions/SemNomeException.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/interface/i_usuario_service.dart';
import 'package:teste_app_api/models/usuario.dart';

void main() {
  setUpInjectors();
  final u = Usuario(idUsuario: 0, nome: 'nome', cpf: '11122233344');
  final httpUsuarioService = getIt<IUsuarioService>();

  test('Deve disparar a SemNomeException()', () {
    expect(httpUsuarioService.funcaoCadastroUsuario(nome: '', cpf: u.cpf),
        throwsA(isA<SemNomeException>()));
  });

  test('Deve disparar uma SemCpfException()', () {
    expect(
        httpUsuarioService.funcaoCadastroUsuario(
            nome: u.nome, cpf: '111222333444'),
        throwsA(isA<CpfInvalidoException>()));
  });
}
