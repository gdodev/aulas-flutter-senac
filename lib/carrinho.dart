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
  double childAspectRatio = 1.0;

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
        title: Row(
          spacing: 8,
          children: [
            Text(
              produtosCarrinho.isNotEmpty
                  ? produtosCarrinho //
                        .map((e) => e.preco)
                        .reduce((value, element) => value + element)
                        .toStringAsFixed(2)
                  : 'Sem produtos no carrinho',
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Text('Largura da tela: ${MediaQuery.of(context).size.width}'),
            ),
            RadioGroup(
              groupValue: childAspectRatio,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    childAspectRatio = value;
                  });
                }
              },
              child: Row(
                spacing: 8,
                children: [
                  Radio.adaptive(value: 1.0),
                  Text('1 / 1'),

                  Radio.adaptive(value: 4 / 3),
                  Text('4/3'),
                  Radio.adaptive(value: 16 / 9),
                  Text('16/9'),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: GridView.count(
        childAspectRatio: childAspectRatio,
        crossAxisCount: 2,
        children: produtos.map(
          (e) {
            // return Text(e.descricao);
            final bool produtoPresenteNoCarrinho =
                produtosCarrinho //
                    .where((element) => element.id == e.id)
                    .isNotEmpty;
            return LayoutBuilder(
              builder: (context, constraints) => GestureDetector(
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
                      Text('Largura do componente: ${constraints.maxWidth}'),
                      Text('Altura do componente: ${constraints.maxHeight}'),
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
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
