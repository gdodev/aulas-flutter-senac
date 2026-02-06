import 'package:amostra/my_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Carrinho2 extends StatefulWidget {
  const Carrinho2({super.key, required this.totalProdutosCarrinho});

  final int totalProdutosCarrinho;

  @override
  State<Carrinho2> createState() => _Carrinho2State();
}

class _Carrinho2State extends State<Carrinho2> {
  @override
  Widget build(BuildContext context) {
    var myChangeNotifier = context.read<MyChangeNotifier>();
    return ListenableBuilder(
      listenable: myChangeNotifier,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Carrinho 2'),
          ),
          body: Column(
            children: [
              Text(myChangeNotifier.childAspectRatio.toString()),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Row(
                  children: [
                    Text('Voltar'),
                    Icon(Icons.arrow_back),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
