import 'package:amostra/produto.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyChangeNotifier extends ChangeNotifier {
  bool isLoading = false;
  List<Produto> produtos = [
    // Produto(id: 1, descricao: 'produto 1'),
    // Produto(id: 2, descricao: 'produto 2', preco: 2.0),
    // Produto(id: 3, descricao: 'produto 3', preco: 3.0),
    // Produto(id: 4, descricao: 'produto 4', preco: 4.0),
  ];
  List<Produto> produtosCarrinho = [];
  double childAspectRatio = 1 / 1;

  void onChanged(double? value) {
    if (value != null) {
      childAspectRatio = value;
      notifyListeners();
    }
  }

  Future<void> fetchProductsFromSupabase() async {
    isLoading = true;
    notifyListeners();

    final supabase = Supabase.instance.client;
    produtos.clear();
    produtos.addAll(
      (await supabase.from('produto').select() as List).map(
        (element) {
          return Produto(
            id: element['id'],
            descricao: element['descricao'],
            preco: element['preco'],
          );
        },
      ).toList(),
    );

    isLoading = false;
    notifyListeners();
  }

  Future<void> insertProductIntoSupabase({required Produto produto}) async {
    final supabase = Supabase.instance.client;
    await supabase.from('produto').insert({
      'id': produto.id,
      'descricao': produto.descricao,
      'preco': produto.preco,
    });
  }

  Future<void> deleteProductFromSupabase({required int idProduto}) async {
    final supabase = Supabase.instance.client;
    await supabase.from('produto').delete().eq('id', idProduto);
  }

  Future<void> updateProductIntoSupabase({required Produto produto}) async {
    final supabase = Supabase.instance.client;
    await supabase
        .from('produto')
        .update({
          'descricao': produto.descricao,
          'preco': produto.preco,
        })
        .eq('id', produto.id);
  }
}
