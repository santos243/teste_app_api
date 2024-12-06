import 'package:http/http.dart';

class SemItensNoPedidoException extends ClientException {
  SemItensNoPedidoException(super.message, {required int codErro});
}
