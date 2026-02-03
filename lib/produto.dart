class Produto {
  final int id;
  final String descricao;
  final double preco;

  Produto({
    required this.id,
    required this.descricao,
    this.preco = 0.0,
  });
}
