// ignore_for_file: use_build_context_synchronously, avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:teste_app_api/core/http/application/my_http.dart';
import 'package:teste_app_api/models/produto.dart';
import 'package:teste_app_api/paginas/pagina_produtos_page.dart';

class PaginaCadastrarProdutoPage extends StatefulWidget {
  const PaginaCadastrarProdutoPage({super.key});

  @override
  State<PaginaCadastrarProdutoPage> createState() =>
      _PaginaCadastrarProdutoPageState();
}

class _PaginaCadastrarProdutoPageState
    extends State<PaginaCadastrarProdutoPage> {
  var controllerNome = TextEditingController();
  var controllerCategoria = TextEditingController();
  var controllerValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Cadastrar novo produto',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Insira o nome do produto:',
                    style: TextStyle(color: Colors.white)),
              ),
              TextField(
                controller: controllerNome,
                style: const TextStyle(color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'Insira qual categoria o produto pertence\n ex: Marcenaria, Eletrodoméstico, Eletrônico, etc',
                    style: TextStyle(color: Colors.white)),
              ),
              TextField(
                controller: controllerCategoria,
                style: const TextStyle(color: Colors.white),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Insira o valor do produto: \n\t\t\t\t\t\tminimo 1,00 real',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextField(
                controller: controllerValor,
                style: const TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade200),
                  onPressed: () => funcaoCadastroProduto(),
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> funcaoCadastroProduto() async {
    final myHttp = MyHttpService<Produto>();

    final p = Produto(
        idProduto: 1,
        nome: controllerNome.text,
        categoria: controllerCategoria.text,
        valor: double.parse(controllerValor.text));

    if (p.nome.length < 2 ||
        p.categoria.length > 20 && p.categoria.length < 2 ||
        p.valor < 1) {
      throw Exception(
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Verifique se os campos foram digitados corretamente e tente novamente"),
          ),
        ),
      );
    }

    await myHttp.post(model: p, entity: 'produtos');

    final usuarioConfirmou = await _showMessageDialog();

    if (!usuarioConfirmou!) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PaginaProdutosPage(
            tipoLista: TipoLista.CONSULTA_PRODUTOS,
          ),
        ),
      );
    }
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (_) => const PaginaCadastroProdutoEfetuadoPage(),
    //   ),
    // );
  }

  Future<bool?> _showMessageDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atenção'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Produto cadastrado com sucesso.'),
                Text('Deseja cadastrar outro produto?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
                controllerCategoria.clear();
                controllerNome.clear();
                controllerValor.clear();
                // controllerCategoria.clear();
                // controllerValor.clear();
                // controllerNome.clear();
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
