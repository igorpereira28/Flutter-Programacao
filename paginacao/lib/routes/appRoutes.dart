import 'package:flutter/material.dart';
import 'package:paginacao/pages/home/homePage.dart';
import 'package:paginacao/pages/listaProduto/listaProduto.dart';
import 'package:paginacao/pages/detalhesCompra/detalhesCompra.dart';
import 'package:paginacao/pages/confirmarPedido/confirmarPedido.dart';

class AppRoutes {
  static const String forms = '/';
  static const String listaProduto = '/listaProduto';
  static const String detalhesCompra = '/detalhesCompra';
  static const String confirmarPedido = '/confirmarPedido';

  static final Map<String, WidgetBuilder> routes = {
    forms: (context) => Home(),
    listaProduto: (context) => ListaProduto(),
    detalhesCompra: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      return DetalhesCompra(produto: args);
    },
    confirmarPedido: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return ConfirmarPedido(
        nomeProduto: args['nomeProduto'] as String,
        valorTotal: args['valorTotal'] as double,
      );
    },
  };
}
