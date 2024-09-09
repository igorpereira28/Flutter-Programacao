import 'package:flutter/material.dart';

class ConfirmarPedido extends StatelessWidget {
  final String nomeProduto;
  final double valorTotal;

  const ConfirmarPedido({
    Key? key,
    required this.nomeProduto,
    required this.valorTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar Pedido'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                height: 150.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Pedido Confirmado',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Text(
                'Produto: $nomeProduto',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                'Valor Total: R\$ ${valorTotal.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.settings.name == '/listaProduto');
                },
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
