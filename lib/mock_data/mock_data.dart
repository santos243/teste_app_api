import 'package:teste_app_api/models/ItemPedido.dart';
import 'package:teste_app_api/models/pedido.dart';
import 'package:teste_app_api/models/produto.dart';
import 'package:teste_app_api/models/usuario.dart';

// produtos instanciados separadamente
final p1 = Produto(
    idProduto: 8, nome: 'Bolsa', categoria: 'Acessórios', valor: 150.00);
final p2 =
    Produto(idProduto: 9, nome: 'Livro', categoria: 'Educação', valor: 50.00);
final p3 = Produto(
    idProduto: 10, nome: 'Luminária', categoria: 'Decoração', valor: 120.00);

// usuarios instanciados separadamente para facilitar outros processos que precisam de um usuario
final usuarioMockado =
    Usuario(idUsuario: 1, nome: 'Ana Silva', cpf: '123.456.789-00');
final u2 = Usuario(idUsuario: 2, nome: 'Carlos Pereira', cpf: '987.654.321-00');

// lista de produtos
final List<Produto> produto = [
  Produto(
      idProduto: 1,
      nome: 'Smartphone',
      categoria: 'Eletrônicos',
      valor: 1500.00),
  Produto(
      idProduto: 2, nome: 'Notebook', categoria: 'Eletrônicos', valor: 3500.00),
  Produto(idProduto: 3, nome: 'Mesa', categoria: 'Móveis', valor: 500.00),
  Produto(idProduto: 4, nome: 'Cadeira', categoria: 'Móveis', valor: 300.00),
  Produto(
      idProduto: 5,
      nome: 'Cafeteira',
      categoria: 'Eletrodomésticos',
      valor: 250.00),
  Produto(
      idProduto: 6,
      nome: 'Ventilador',
      categoria: 'Eletrodomésticos',
      valor: 200.00),
  Produto(
      idProduto: 7, nome: 'Relógio', categoria: 'Acessórios', valor: 400.00),
];

// lista de usuarios
final List<Usuario> usuarios = [
  Usuario(idUsuario: 3, nome: 'Beatriz Souza', cpf: '456.789.123-00'),
  Usuario(idUsuario: 4, nome: 'Diego Costa', cpf: '789.123.456-00'),
  Usuario(idUsuario: 5, nome: 'Fernanda Lima', cpf: '321.654.987-00'),
  Usuario(idUsuario: 6, nome: 'Gustavo Almeida', cpf: '654.321.987-00'),
  Usuario(idUsuario: 7, nome: 'Isabela Ferreira', cpf: '321.987.654-00'),
  Usuario(idUsuario: 8, nome: 'João Mendes', cpf: '123.789.456-00'),
  Usuario(idUsuario: 9, nome: 'Larissa Oliveira', cpf: '987.123.654-00'),
  Usuario(idUsuario: 10, nome: 'Marcos Silva', cpf: '456.123.789-00'),
];

// lista de item pedidos.
final List<ItemPedido> itemPedidos1 = [
  ItemPedido(
    idItemPedido: 4,
    produto: p1,
    idProduto: p1.idProduto,
    quantidade: 4,
  ),
  ItemPedido(
    idItemPedido: 3,
    produto: p2,
    idProduto: p2.idProduto,
    quantidade: 7,
  ),
  ItemPedido(
    idItemPedido: 5,
    produto: p3,
    idProduto: p3.idProduto,
    quantidade: 2,
  ),
];

// lista de item pedidos para usar em outro pedido.
final List<ItemPedido> itemPedidos2 = [
  ItemPedido(
    idItemPedido: 5,
    produto: p3,
    idProduto: p3.idProduto,
    quantidade: 2,
  ),
];

final pedidoMockado = Pedido(
  idPedido: 2,
  usuario: usuarioMockado,
  idUsuario: usuarioMockado.idUsuario,
  itens: [],
);

final pedidoMockado2 = Pedido(
  idPedido: 2,
  usuario: usuarioMockado,
  idUsuario: null,
  itens: itemPedidos2,
);

// lista de pedidos
final List<Pedido> pedidos = [
  Pedido(
    idPedido: 2,
    usuario: usuarioMockado,
    idUsuario: usuarioMockado.idUsuario,
    itens: itemPedidos1,
  ),
  Pedido(
    idPedido: 3,
    usuario: u2,
    idUsuario: u2.idUsuario,
    itens: itemPedidos2,
  ),
];
