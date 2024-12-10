import 'package:get_it/get_it.dart';
import 'package:teste_app_api/core/http/application/produto_repository.dart';
import 'package:teste_app_api/mock_data/produto_repository_mock.dart';

final GetIt getItTest = GetIt.instance;

void setUpInjectorsTest() {
  getItTest
      .registerLazySingleton<ProdutoRepository>(() => ProdutoRepositoryMock());
}
