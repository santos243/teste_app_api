import 'package:get_it/get_it.dart';
import 'package:teste_app_api/core/http/application/produto_repository.dart';
import 'package:teste_app_api/core/http/application/produto_repository_http.dart';
import 'package:teste_app_api/interface/i_pedido_service.dart';
import 'package:teste_app_api/interface/i_produto_service.dart';
import 'package:teste_app_api/interface/I_my_http_dart.dart';
import 'package:teste_app_api/core/http/application/my_http_service.dart';
import 'package:teste_app_api/interface/i_usuario_service.dart';
import 'package:teste_app_api/services/pedido_service_impl.dart';
import 'package:teste_app_api/services/produto_service_impl.dart';
import 'package:teste_app_api/services/usuario_service_impl.dart';

final GetIt getIt = GetIt.instance;

// fazer injeção de dependencia para criar uma interface service para classe de pedidos.
void setUpInjectors() {
  try {
    // getIt.registerLazySingleton<ProdutoRepository>(
    //     () => ProdutoRepositoryHttp(getIt<IMyHttpDart>()));
    getIt.registerLazySingleton<ProdutoRepository>(
        () => ProdutoRepositoryHttp(getIt<IMyHttpDart>()));
  } catch (e) {
    print('Erro ao registrar ProdutoRepository: $e');
  }
  try {
    getIt.registerLazySingleton<IProdutoService>(
        () => ProdutoServiceImpl(getIt<ProdutoRepository>()));
  } catch (e) {
    print('Erro ao registrar IProdutoService: $e');
  }
  try {
    getIt.registerLazySingleton<IPedidoService>(
        () => PedidoServiceImpl(getIt<IMyHttpDart>()));
  } catch (e) {
    print('Erro ao registrar IPedidoService: $e');
  }
  try {
    getIt.registerLazySingleton<IUsuarioService>(
        () => UsuarioServiceImpl(getIt<IMyHttpDart>()));
  } catch (e) {
    print('Erro ao registrar IUsuarioService: $e');
  }
  try {
    getIt.registerLazySingleton<IMyHttpDart>(() => MyHttpService());
  } catch (e) {
    print('Erro ao registrar IMyHttpDart: $e');
  }
}
