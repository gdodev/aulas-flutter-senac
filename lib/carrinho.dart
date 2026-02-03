import 'package:amostra/produto.dart';
import 'package:flutter/material.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  List<Produto> produtos = [];
  List<Produto> produtosCarrinho = [];

  @override
  void initState() {
    super.initState();
    produtos = [
      Produto(
        id: 1,
        descricao: 'produto 1',
      ),
      Produto(id: 2, descricao: 'produto 2', preco: 2.0),
      Produto(id: 3, descricao: 'produto 3', preco: 3.0),
      Produto(id: 4, descricao: 'produto 4', preco: 4.0),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle estiloTextos = TextStyle(
      fontSize: 18,
      color: Colors.white,
      background: Paint()..color = Colors.blue,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          produtosCarrinho.isNotEmpty
              ? produtosCarrinho //
                    .map((e) => e.preco)
                    .reduce((value, element) => value + element)
                    .toStringAsFixed(2)
              : 'Sem produtos no carrinho',
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: produtos.map(
          (e) {
            // return Text(e.descricao);
            final bool produtoPresenteNoCarrinho =
                produtosCarrinho //
                    .where((element) => element.id == e.id)
                    .isNotEmpty;
            return GestureDetector(
              onTap: () {
                setState(() {
                  produtoPresenteNoCarrinho ? produtosCarrinho.remove(e) : produtosCarrinho.add(e);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8.0,
                  children: [
                    Text(
                      e.id.toString(),
                      style: estiloTextos,
                    ),
                    Text(
                      e.descricao,
                      style: estiloTextos,
                    ),
                    Text(
                      e.preco.toStringAsFixed(2),
                      style: estiloTextos,
                    ),
                    produtoPresenteNoCarrinho ? Icon(Icons.check, color: Colors.green) : Icon(Icons.cancel, color: Colors.red),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
