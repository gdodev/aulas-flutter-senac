import 'package:amostra/my_change_notifier.dart';
import 'package:amostra/produto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormularioProduto extends StatefulWidget {
  const FormularioProduto({super.key});

  @override
  State<FormularioProduto> createState() => _FormularioProdutoState();
}

class _FormularioProdutoState extends State<FormularioProduto> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController precoController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            spacing: 16,
            children: [
              TextFormField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: 'ID Produto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (int.tryParse(value ?? '') == null) {
                    return 'ID do produto deve ser um inteiro';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: descricaoController,
                decoration: InputDecoration(
                  labelText: 'Descrição Produto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null) {
                    if (value!.isEmpty) {
                      return 'Descrição não pode ser vazia';
                    }
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: precoController,
                decoration: InputDecoration(
                  labelText: 'Preço Produto',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (double.tryParse(value ?? '') == null) {
                    return 'Preço deve ser um valor com casas decimais';
                  }
                  final preco = double.parse(value!);
                  if (preco < 0) {
                    return 'Preço não pode ser negativo';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // print('id: ${idController.text}');
                  // print('descricao: ${descricaoController.text}');
                  // print('preco: ${precoController.text}');
                  if (formKey.currentState!.validate()) {
                    context.read<MyChangeNotifier>().produtos.add(
                      Produto(
                        id: int.parse(idController.text),
                        descricao: descricaoController.text,
                        preco: double.parse(precoController.text),
                      ),
                    );
                  }
                },
                child: Text('Submeter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
