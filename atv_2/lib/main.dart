import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> userList = [];

  // Método assíncrono para consumir informações da API
  Future<void> fetchData() async {
    try {
      // Realiza a requisição
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

      // Verifica o êxito da requisição
      if (response.statusCode == 200) {
        // Converte a resposta em um objeto JSON
        final jsonResponse = json.decode(response.body);
        // Atualiza o estado
        setState(() {
          userList = jsonResponse;
        });
      } else {
        // Erro na requisição
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      // Erro geral
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Users List'),
        ),
        body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            final user = userList[index];
            // Define a cor de fundo alternada
            final backgroundColor = index % 2 == 0 ? Colors.grey[300] : Colors.white;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text('Name: ${user['name']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Username: ${user['username']}'),
                    Text('Email: ${user['email']}'),
                    Text('Address: ${user['address']['street']}, ${user['address']['city']}'),
                    Text('Phone: ${user['phone']}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
