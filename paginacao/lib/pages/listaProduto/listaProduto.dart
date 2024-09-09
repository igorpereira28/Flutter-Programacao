import 'package:flutter/material.dart';
import 'package:paginacao/pages/detalhesCompra/detalhesCompra.dart';

class ListaProduto extends StatelessWidget {
  final List<Map<String, dynamic>> produtos = [
    {'nome': 'PC GAMER', 'descricao': 'Ideal para jogos intensivos e multitarefas.', 'valor': 4999.99},
    {'nome': 'Máquina de lavar', 'descricao': 'Ideal para lavar suas roupas com eficiência e economia.', 'valor': 1899.00},
    {'nome': 'TV SMART', 'descricao': 'Televisor com tecnologia 4K e acesso a aplicativos de streaming.', 'valor': 2499.00},
    {'nome': 'SOFÁ', 'descricao': 'Confortável e elegante, perfeito para sua sala de estar.', 'valor': 1499.00},
    {'nome': 'Geladeira', 'descricao': 'Geladeira com freezer e tecnologia de economia de energia.', 'valor': 2299.00},
    {'nome': 'Fogão', 'descricao': 'Fogão com cinco bocas e forno embutido para facilitar o preparo das suas refeições.', 'valor': 1599.00},
    {'nome': 'Micro-ondas', 'descricao': 'Micro-ondas com funções de descongelamento e aquecimento rápido.', 'valor': 499.00},
    {'nome': 'Aspirador de pó', 'descricao': 'Aspirador com filtro HEPA para limpeza profunda e eficiente.', 'valor': 799.00},
    {'nome': 'Máquina de café', 'descricao': 'Máquina de café expresso com funções de personalização de bebidas.', 'valor': 649.00},
    {'nome': 'Ar Condicionado', 'descricao': 'Ar condicionado com controle remoto e ajuste de temperatura.', 'valor': 1399.00},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
      ),
      body: ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return Card(
            child: ListTile(
              title: Text(produto['nome'] ?? ''),
              subtitle: Text('${produto['descricao'] ?? ''} - R\$ ${produto['valor']?.toStringAsFixed(2) ?? '0.00'}'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetalhesCompra(produto: produto),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
