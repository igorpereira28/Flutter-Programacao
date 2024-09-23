import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avaliação de Notas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png', height: 150.0),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Acessar Tela 1'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela 1 - Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Digite o nome de usuário'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Digite a senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Erro'),
                      content: Text('Por favor, preencha todos os campos.'),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                  return;
                }
                var response = await http.post(
                  Uri.parse('http://127.0.0.1:5000/login'),
                );
                var token = jsonDecode(response.body)['token'];
                setState(() {
                  _token = token;
                });
              },
              child: Text('Realizar Login'),
            ),
            if (_token != null) ...[
              SizedBox(height: 20),
              Text('Token: $_token'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotesPage(_token!)),
                  );
                },
                child: Text('Ir para Notas'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class NotesPage extends StatefulWidget {
  final String token;

  NotesPage(this.token);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  String? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela 2 - Notas dos Alunos'),
      ),
      body: Center(
        child: FutureBuilder(
          future: fetchStudentNotes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Erro ao carregar dados');
            } else {
              List<Student> students = snapshot.data ?? [];

              // Aplicar filtro com base na seleção
              List<Student> filteredStudents;
              if (_selectedFilter == 'menos60') {
                filteredStudents = students.where((student) => student.nota < 60).toList();
              } else if (_selectedFilter == 'entre60e99') {
                filteredStudents = students.where((student) => student.nota >= 60 && student.nota < 100).toList();
              } else if (_selectedFilter == 'igual100') {
                filteredStudents = students.where((student) => student.nota == 100).toList();
              } else {
                filteredStudents = students; // Sem filtro, exibe todos
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        Color backgroundColor = Colors.white;
                        if (filteredStudents[index].nota < 60) {
                          backgroundColor = Colors.yellow;
                        } else if (filteredStudents[index].nota == 100) {
                          backgroundColor = Colors.green;
                        } else {
                          backgroundColor = Colors.blue;
                        }

                        return Container(
                          color: backgroundColor,
                          padding: EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(filteredStudents[index].nome),
                            subtitle: Text('Matrícula: ${filteredStudents[index].matricula} - Nota: ${filteredStudents[index].nota}'),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedFilter == 'menos60' ? Colors.black : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedFilter = 'menos60';
                            });
                          },
                          child: Text('Nota < 60'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedFilter == 'entre60e99' ? Colors.black : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedFilter = 'entre60e99';
                            });
                          },
                          child: Text('Nota >= 60 exceto 100'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _selectedFilter == 'igual100' ? Colors.black : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _selectedFilter = 'igual100';
                            });
                          },
                          child: Text('Nota = 100'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<Student>> fetchStudentNotes() async {
    var response = await http.get(
      Uri.parse('http://127.0.0.1:5000/notasAlunos'),
      headers: {
        'Authorization': 'Bearer ${widget.token}',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Student> students = data.map((e) => Student.fromJson(e)).toList();
      return students;
    } else {
      throw Exception('Erro ao carregar notas');
    }
  }
}

class Student {
  final String matricula;
  final String nome;
  final int nota;

  Student({required this.matricula, required this.nome, required this.nota});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      matricula: json['matricula'],
      nome: json['nome'],
      nota: json['nota'],
    );
  }
}