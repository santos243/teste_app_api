import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teste_app_api/exceptions/SemIdUsuarioNoPedido.dart';
import 'package:teste_app_api/exceptions/SemItensNoPedidoException.dart';
import 'package:teste_app_api/getit/setUpInjectors.dart';
import 'package:teste_app_api/interface/i_pedido_service.dart';
import 'package:teste_app_api/mock_data/mock_data.dart';

void main() {
  setUpInjectors();

  final httpPedidoService = getIt<IPedidoService>();
  final pedido = pedidoMockado;
  final pedidoSemIdUsuario = pedidoMockado2;

  test(
      'deve disparar uma exception quando o pedido com uma lista de item pedido vazia',
      () {
    expect(httpPedidoService.funcaoCriarPedido(pedido: pedido),
        throwsA(isA<SemItensNoPedidoException>()));
  });

  test('Deve disparar uma exception para idUsuario nulo', () {
    expect(httpPedidoService.funcaoCriarPedido(pedido: pedidoSemIdUsuario),
        throwsA(isA<SemIdUsuarioNoPedido>()));
  });
}
