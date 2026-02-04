import 'package:amostra/produto.dart';
import 'package:flutter/material.dart';

class MyChangeNotifier extends ChangeNotifier {
  List<Produto> produtos = [
    Produto(
      id: 1,
      descricao: 'produto 1',
    ),
    Produto(id: 2, descricao: 'produto 2', preco: 2.0),
    Produto(id: 3, descricao: 'produto 3', preco: 3.0),
    Produto(id: 4, descricao: 'produto 4', preco: 4.0),
  ];
  List<Produto> produtosCarrinho = [];
  double childAspectRatio = 1 / 1;

  void onChanged(double? value) {
    if (value != null) {
      childAspectRatio = value;
      notifyListeners();
    }
  }
}
