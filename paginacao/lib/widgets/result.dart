import 'package:flutter/material.dart';

class ResultText extends StatelessWidget {
  final String result;
  final Color color;

  const ResultText({
    Key? key,
    required this.result,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Resposta: $result',
      style: TextStyle(fontSize: 24.0, color: color),
    );
  }
}