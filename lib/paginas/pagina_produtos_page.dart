// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/ItemPedido.dart';
import 'package:teste_app_api/models/pedido.dart';
import 'package:teste_app_api/models/produto.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_produto_page.dart';
import 'package:teste_app_api/paginas/pagina_info_produto_page.dart';
import 'package:teste_app_api/providers/PedidoProvider.dart';

// ignore: constant_identifier_names
enum TipoLista { CONSULTA_PRODUTOS, CRIACAO_PED }

class PaginaProdutosPage extends StatefulWidget {
  final TipoLista tipoLista;
  const PaginaProdutosPage({super.key, required this.tipoLista});

  @override
  State<PaginaProdutosPage> createState() => _PaginaProdutosPageState();
}

class _PaginaProdutosPageState extends State<PaginaProdutosPage> {
  // late CarrinhoRepositoryTeste carrinho;
  final listaProdutos = <Produto>[];

  @override
  Widget build(BuildContext context) {
    final carrinhoProvider =
        Provider.of<PedidoProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: widget.tipoLista == TipoLista.CONSULTA_PRODUTOS
            ? Text(
                'Requisição de produtos',
                style: TextStyle(color: Colors.white),
              )
            : Text(
                'Selecione a quantidade',
                style: TextStyle(color: Colors.white),
              ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: FutureBuilder(
            future: funcaoMostrarProdutos(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              snapshot.data?.sort((a, b) => a.idProduto.compareTo(b.idProduto));
              final listaProdutos = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        widget.tipoLista == TipoLista.CRIACAO_PED
                            ? const SizedBox.shrink()
                            : ElevatedButton(
                                onPressed: () => irParaCadastroProduto(),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent.shade400),
                                child: Row(
                                  children: const [
                                    Text(
                                      'Cadastrar ',
                                      style: TextStyle(color: Colors.white),
                                      textScaler: TextScaler.linear(1.2),
                                    ),
                                    Icon(
                                      Icons.add_business_outlined,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListView(
                          children: listaProdutos!
                              .map(
                                (itemProduto) => Row(
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Expanded(
                                      child: ListTile(
                                        leading: Image.network(
                                            'https://cdn-icons-png.flaticon.com/512/5902/5902522.png',
                                            height: 50,
                                            width: 50,
                                            fit: BoxFit.cover),
                                        // onTap: () {
                                        // setState(() {});
                                        // if (widget.tipoLista ==
                                        //     TipoLista.CRIACAO_PED) {
                                        //   print(itemProduto);
                                        //   setState(() {});
                                        // }
                                        // },
                                        title: Text('${itemProduto.nome}  -  ${itemProduto.idProduto}'),
                                        subtitle:
                                            Text('Valor  -  ${itemProduto.valor} reais'),
                                        subtitleTextStyle:
                                            TextStyle(color: Colors.white60),
                                        titleTextStyle:
                                            TextStyle(color: Colors.white),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            widget.tipoLista ==
                                                    TipoLista.CRIACAO_PED
                                                ? IconButton(
                                                    onPressed: () {
                                                      // remover itens do carrinho e mostrar o total do lado
                                                      try {
                                                        carrinhoProvider.removeItemPedido(
                                                            carrinhoProvider
                                                                    .getItemPedido(
                                                                        itemProduto)
                                                                as ItemPedido);
                                                      } on Exception catch (Exception) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    Exception
                                                                        .toString())));
                                                      }

                                                      // var produtoE = carrinhoProvider.getItemPedido(itemProduto)!.quantidade;
                                                      // print(produtoE);
                                                    },
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : IconButton(
                                                    onPressed: () =>
                                                        irParaInfoProdutos(
                                                            itemProduto),
                                                    icon: Icon(
                                                      Icons.info_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                            widget.tipoLista ==
                                                    TipoLista.CRIACAO_PED
                                                ? getItemPedidoQtdWidget(
                                                    itemProduto)
                                                : SizedBox.shrink(),
                                            widget.tipoLista ==
                                                    TipoLista.CRIACAO_PED
                                                ? IconButton(
                                                    onPressed: () {
                                                      var counter = 0;
                                                      counter++;
                                                      // adicionar item ao carrinho, e mostrar o total adicionado ao lado
                                                      carrinhoProvider.addItem(
                                                          ItemPedido(
                                                              produto:
                                                                  itemProduto,
                                                              quantidade:
                                                                  counter));
                                                    },
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : IconButton(
                                                    onPressed: () =>
                                                        deleteProduto(
                                                            itemProduto),
                                                    icon: Icon(
                                                        Icons
                                                            .delete_outline_rounded,
                                                        color: Colors.white),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    widget.tipoLista == TipoLista.CRIACAO_PED
                        ? getValorTotalPedido(carrinhoProvider.pedido.itens)
                        : SizedBox.shrink(),
                    ElevatedButton(
                        onPressed: () async {
                          Pedido pedido = Pedido(usuario: carrinhoProvider.pedido.usuario, itens: carrinhoProvider.pedido.itens);
                          await confirmarPedido(pedido);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent.shade400),
                        child: Text("Confirmar pedido", style: TextStyle(color: Colors.white, fontSize: 16),)),
                  ],
                ),
              );
            }),
      ),
    );
  }

  Future<List<Produto>> funcaoMostrarProdutos() async {
    listaProdutos.clear();

    final myHttp = MyHttpService<Produto>();

    return await myHttp.get(entity: 'produtos', builder: Produto.fromMap);
  }

  Future<void> deleteProduto(itemProduto) async {
    final myHttp = MyHttpService<Produto>();

    await myHttp.delete(entity: 'produtos', id: itemProduto.id_produto);
    await funcaoMostrarProdutos();
  }

  void irParaInfoProdutos(Produto itemProduto) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => PaginaInfoProdutoPage(itemProduto: itemProduto)),
    );
  }

  void irParaCadastroProduto() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaginaCadastrarProdutoPage()),
    );
  }

  Future<void> confirmarPedido(Pedido pedido) async {
    final myHttp = MyHttpService<Pedido>();

    await myHttp.post(model: pedido, entity: 'pedido');
  }

  Widget getItemPedidoQtdWidget(Produto produto) {
    return Consumer<PedidoProvider>(
      builder: (_, provider, child) {
        final itemPedido = provider.getItemPedido(produto);
        return Text(
          itemPedido == null ? '0' : itemPedido.quantidade.toString(),
          style: TextStyle(color: Colors.white, fontSize: 12),
        );
      },
    );
  }

  Widget getValorTotalPedido(List<ItemPedido> itens) {
    return Consumer<PedidoProvider>(
      builder: (context, value, child) {
        final valorTotal = value.getTotalValor(itens);
        return Text(
          "Total: $valorTotal reais",
          style: TextStyle(color: Colors.white, fontSize: 35),
        );
      },
    );
  }
}
