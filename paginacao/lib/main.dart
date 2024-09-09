import 'package:flutter/material.dart';
import 'package:paginacao/routes/appRoutes.dart'; // Caminho correto para AppRoutes

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Aplicação',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.forms,
      routes: AppRoutes.routes,
    );
  }
}
