import 'package:get_it/get_it.dart';
import 'package:teste_app_api/abstract/IProdutoService.dart';
import 'package:teste_app_api/abstract/I_my_http_dart.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/i_model.dart';
import 'package:teste_app_api/models/usuario.dart';
import 'package:teste_app_api/services/auth_produto_service.dart';


final getIt = GetIt.instance;

void setUpInjectors() {
getIt.registerSingleton<IProdutoService>(AuthProdutoService());
getIt.registerSingleton<IMyHttpDart>(MyHttpService());
}
