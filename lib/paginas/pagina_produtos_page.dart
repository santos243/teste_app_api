// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, avoid_types_as_parameter_names, non_constant_identifier_names, empty_catches, unused_catch_clause, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/ItemPedido.dart';
import 'package:teste_app_api/models/pedido.dart';
import 'package:teste_app_api/models/produto.dart';
import 'package:teste_app_api/paginas/pagina_cadastrar_produto_page.dart';
import 'package:teste_app_api/paginas/pagina_info_produto_page.dart';
import 'package:teste_app_api/paginas/pagina_usuarios_page.dart';
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
  final myHttp = MyHttpService<Produto>();

  Future<void> funcaoMostrarProdutos() async {
    listaProdutos.clear();
    final produtosEncontrados =
        await myHttp.get(entity: 'produtos', builder: Produto.fromMap);
    produtosEncontrados.sort((a, b) => a.idProduto.compareTo(b.idProduto));
    listaProdutos.addAll(produtosEncontrados);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await funcaoMostrarProdutos();
    });
  }

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
                'Produtos',
                style: TextStyle(color: Colors.white),
              )
            : Text(
                'Selecione a quantidade',
                style: TextStyle(color: Colors.white),
              ),
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: Padding(
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
                child: ListView.builder(
                  itemCount: listaProdutos.length,
                  itemBuilder: (context, index) {
                    final itemProduto = listaProdutos[index];
                    return Row(
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
                            title: Text(
                                '${itemProduto.nome}  -  ${itemProduto.idProduto}'),
                            subtitle: Text('R\$ ${itemProduto.valor}'),
                            onTap: () => irParaInfoProdutos(itemProduto),
                            subtitleTextStyle: TextStyle(color: Colors.white60),
                            titleTextStyle: TextStyle(color: Colors.white),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.tipoLista == TipoLista.CRIACAO_PED
                                    ? IconButton(
                                        onPressed: () {
                                          // remover itens do carrinho e mostrar o total do lado
                                          try {
                                            carrinhoProvider.removeItemPedido(
                                                carrinhoProvider.getItemPedido(
                                                    itemProduto)!);
                                          } catch (Exception) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Não foi possivel diminuir a quantidade do produto.')));
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
                                            irParaInfoProdutos(itemProduto),
                                        icon: Icon(
                                          Icons.info_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                widget.tipoLista == TipoLista.CRIACAO_PED
                                    ? getItemPedidoQtdWidget(itemProduto)
                                    : SizedBox.shrink(),
                                widget.tipoLista == TipoLista.CRIACAO_PED
                                    ? IconButton(
                                        onPressed: () {
                                          var counter = 0;
                                          counter++;
                                          // adicionar item ao carrinho, e mostrar o total adicionado ao lado
                                          carrinhoProvider.addItem(ItemPedido(
                                              produto: itemProduto,
                                              idProduto: itemProduto.idProduto,
                                              quantidade: counter));
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                      )
                                    : IconButton(
                                        onPressed: () async {
                                          await deleteProduto(itemProduto);
                                          await funcaoMostrarProdutos();
                                        },
                                        icon: Icon(Icons.delete_outline_rounded,
                                            color: Colors.white),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            widget.tipoLista == TipoLista.CRIACAO_PED
                ? getValorTotalPedido(carrinhoProvider.pedido.itens)
                : SizedBox.shrink(),
            widget.tipoLista == TipoLista.CRIACAO_PED
                ? ElevatedButton(
                    onPressed: () async {
                      final pedidoPronto = Pedido(
                          idUsuario: carrinhoProvider.pedido.idUsuario,
                          itens: carrinhoProvider.pedido.itens);
                      await confirmarPedido(
                          MyHttpService<Pedido>(), pedidoPronto);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade400),
                    child: Text(
                      "Confirmar pedido",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ))
                : ElevatedButton(
                    onPressed: () => irParaEfetuarPedido(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent.shade400),
                    child: Text(
                      'Fazer pedido',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
          ],
        ),
      )),
    );
  }

  Future<void> deleteProduto(itemProduto) async {
    // final myHttp = MyHttpService<Produto>();

    final usuarioConfirmou = await _showMyDialogDelete();
    if (usuarioConfirmou!) {
      await myHttp.delete(entity: 'produtos', id: itemProduto.idProduto);
    }
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

  void irParaEfetuarPedido() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PaginaUsuariosPage(tipoListagem: TipoListagem.CRIACAO_PEDIDO),
      ),
    );
  }

  // confirma o pedido
  Future<void> confirmarPedido(
      MyHttpService<Pedido> myHttp, Pedido pedido) async {
    // final myHttp = MyHttpService<Pedido>();

    // requisição
    await myHttp.post(model: pedido, entity: 'pedido');

    // depois que a requisição é feita, o carrinho é restaurado.
    pedido.itens.clear();

    // quando terminar a requisição, será mostrado um dialog
    final usuarioConfirmou = await _showMyDialog();

    // se for falso*
    if (!usuarioConfirmou!) {
      // fecha a tela do carrinho se a condição for satisfeita.
      Navigator.pop(context);
    }
    // se a condição anterior for satisfeita, agora fechará a tela de usuários, senão fecha apenas a tela de produtos.
    Navigator.pop(context);
  }

  // widget contador que exibe a quantidade de cada produto no carrinho(PedidoProvider).
  Widget getItemPedidoQtdWidget(Produto produto) {
    // consome informações do PedidoProvider
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

  // widget contador que calcula o valor total de todos os itens dentro do carrinho.
  Widget getValorTotalPedido(List<ItemPedido> itens) {
    return Consumer<PedidoProvider>(
      builder: (context, value, child) {
        final valorTotal = value.getTotalValor(itens);
        return Text(
          "Total: R\$ $valorTotal",
          style: TextStyle(color: Colors.white, fontSize: 30),
        );
      },
    );
  }

  Future<bool?> _showMyDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // o usuario precisa pressionar sim ou não.
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const SingleChildScrollView(
            child: ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                Text('Pedido efetuado'),
                Text('Deseja realizar um novo pedido?'),
              ],
            ),
          ),
          // botões de ação
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showMyDialogDelete() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // o usuario precisa pressionar sim ou não.
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const SingleChildScrollView(
            child: ListBody(
              mainAxis: Axis.vertical,
              children: <Widget>[
                Text('Você está prestes a excluir o produto'),
                Text('Deseja continuar?'),
              ],
            ),
          ),
          // botões de ação
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
