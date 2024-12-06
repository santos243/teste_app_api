import 'package:http/http.dart';

class SemIdUsuarioNoPedido extends ClientException {
  int codErro;
  SemIdUsuarioNoPedido(super.message, this.codErro);
}
