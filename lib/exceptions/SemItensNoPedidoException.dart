import 'package:http/http.dart';

class SemItensNoPedidoException extends ClientException {
  SemItensNoPedidoException(super.message);

  @override
  String toString(){
    return 'Não foi possível efetuar o pedido, pois não foi selecionado nenhum item';
  }
}
