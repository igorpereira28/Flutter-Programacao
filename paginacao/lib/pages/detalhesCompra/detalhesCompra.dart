import 'package:flutter/material.dart';
import 'package:paginacao/pages/confirmarPedido/confirmarPedido.dart';

class DetalhesCompra extends StatefulWidget {
  final Map<String, dynamic> produto;

  const DetalhesCompra({Key? key, required this.produto}) : super(key: key);

  @override
  _DetalhesCompraState createState() => _DetalhesCompraState();
}

class _DetalhesCompraState extends State<DetalhesCompra> {
  final TextEditingController _quantidadeController = TextEditingController();
  double valorProduto = 0.0;

  @override
  void initState() {
    super.initState();
    valorProduto = widget.produto['valor'] ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final nomeProduto = widget.produto['nome'] ?? 'Produto';
    final descricaoProduto = widget.produto['descricao'] ?? 'Descrição';

    return Scaffold(
      appBar: AppBar(
        title: Text(nomeProduto),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              nomeProduto,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(descricaoProduto),
            SizedBox(height: 16.0),
            TextField(
              controller: _quantidadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Valor: R\$ ${valorProduto}',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final quantidade = double.tryParse(_quantidadeController.text) ?? 0;
                    final valorTotal = quantidade * valorProduto;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ConfirmarPedido(
                          nomeProduto: nomeProduto,
                          valorTotal: valorTotal,
                        ),
                      ),
                    );
                  },
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calcularValorTotal() {
    final quantidade = double.tryParse(_quantidadeController.text) ?? 0;
    return quantidade * valorProduto;
  }
}
