import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  bool _loginValido() {
    return _loginController.text == 'admin' && _senhaController.text == '123';
  }

  void _entrar() {
    if (_loginValido()) {
      Navigator.of(context).pushNamed('/listaProduto');
    } else {
      // Lógica para tratar erro de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibindo a imagem no topo
            Image.asset(
              'assets/logo.png',  // Certifique-se que o caminho está correto
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _loginController,
              decoration: InputDecoration(labelText: 'Login'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _entrar,
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
