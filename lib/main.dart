import 'package:amostra/carrinho.dart';
import 'package:amostra/carrinho2.dart';
import 'package:amostra/carrinho2_arguments.dart';
import 'package:amostra/formulario_produto.dart';
import 'package:amostra/my_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // final preferences = await SharedPreferences.getInstance();
  // print(preferences.getString('teste'));

  // final int a = 0;
  // a = 1;

  // const a = 0;

  // var a = 0;
  // print('tipo da variável a ${a.runtimeType}');
  // print('1 + 1 ${1 + 1}');
  // print('$a');

  // int b = 1;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyChangeNotifier(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => Carrinho(),
      //   '/carrinho2': (context) => Carrinho2(),
      // },
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(
            builder: (context) {
              return Carrinho();
            },
          );
        }
        if (settings.name == '/carrinho2') {
          final args = settings.arguments as Carrinho2Arguments;

          return MaterialPageRoute(
            builder: (context) {
              return Carrinho2(
                totalProdutosCarrinho: args.totalProdutosCarrinho,
              );
            },
          );
        }
        if (settings.name == '/formulario-produto') {
          return MaterialPageRoute(
            builder: (context) {
              return FormularioProduto();
            },
          );
        }
      },
    );
  }
}
