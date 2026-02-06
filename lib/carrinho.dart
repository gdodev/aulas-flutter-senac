import 'package:amostra/carrinho2.dart';
import 'package:amostra/carrinho2_arguments.dart';
import 'package:amostra/my_change_notifier.dart';
import 'package:amostra/produto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Carrinho extends StatefulWidget {
  const Carrinho({super.key});

  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  @override
  Widget build(BuildContext context) {
    MyChangeNotifier myChangeNotifier = context.read();

    final TextStyle estiloTextos = TextStyle(
      fontSize: 18,
      color: Colors.white,
      background: Paint()..color = Colors.blue,
    );

    return ListenableBuilder(
      listenable: myChangeNotifier,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: Row(
            spacing: 8,
            children: [
              Text(
                myChangeNotifier.produtosCarrinho.isNotEmpty
                    ? myChangeNotifier
                          .produtosCarrinho //
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
                child: Text('Largura da tela: ${MediaQuery.of(context).size.width.toStringAsFixed(2)}'),
              ),
              RadioGroup(
                groupValue: myChangeNotifier.childAspectRatio,
                onChanged: (value) {
                  myChangeNotifier.onChanged(value);
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
        body: Column(
          children: [
            ElevatedButton(
              // onPressed: () => Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => Carrinho2(),
              //   ),
              // ),
              onPressed: () => Navigator.of(context).pushNamed(
                '/carrinho2',
              ),
              child: Text('Navegar Carrinho 2 (push)'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed(
                '/carrinho2',
                arguments: Carrinho2Arguments(
                  totalProdutosCarrinho: myChangeNotifier.produtosCarrinho.length,
                ),
              ),
              child: Text('Navegar Carrinho 2 (push replacement)'),
            ),
            Expanded(
              child: GridView.count(
                childAspectRatio: myChangeNotifier.childAspectRatio,
                crossAxisCount: 2,
                children: myChangeNotifier.produtos.map(
                  (e) {
                    // return Text(e.descricao);
                    final bool produtoPresenteNoCarrinho = myChangeNotifier
                        .produtosCarrinho //
                        .where((element) => element.id == e.id)
                        .isNotEmpty;
                    return LayoutBuilder(
                      builder: (context, constraints) => GestureDetector(
                        onTap: () {
                          setState(() {
                            produtoPresenteNoCarrinho ? myChangeNotifier.produtosCarrinho.remove(e) : myChangeNotifier.produtosCarrinho.add(e);
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
            ),
          ],
        ),
      ),
    );
  }
}
