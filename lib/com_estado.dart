import 'package:flutter/material.dart';

class ComEstado extends StatefulWidget {
  const ComEstado({super.key});

  @override
  State<ComEstado> createState() => _ComEstadoState();
}

class _ComEstadoState extends State<ComEstado> {
  int contador = 0;
  int viewMode = 0;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget switchViewMode = Switch.adaptive(
      value: viewMode == 1,
      onChanged: (value) {
        setState(() {
          // viewMode = value == true ? 1 : 0;
          if (value) {
            viewMode = 1;
          } else {
            viewMode = 0;
          }
        });
      },
    );
    List<Widget> children = [
      Text('Valor da contagem'),
      Text(contador.toString()),
      ElevatedButton(
        onPressed: () {
          // contador = contador + 1;
          setState(() {
            contador++;
          });
        },
        child: Text(
          'Incrementar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ];
    if (isLoading == true) {
      return CircularProgressIndicator.adaptive();
    }
    if (viewMode == 0) {
      return Column(
        children: [
          switchViewMode,
          Row(
            spacing: 8,
            children: children,
          ),
        ],
      );
    } else {
      return Column(
        spacing: 8,
        children: [
          switchViewMode,
          Text('Valor da contagem'),
          Text(contador.toString()),
          ElevatedButton(
            onPressed: () {
              // contador = contador + 1;
              setState(() {
                contador++;
              });
            },
            child: Text(
              'Incrementar',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
  }
}
