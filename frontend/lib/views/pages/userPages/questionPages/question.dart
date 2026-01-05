import 'package:flutter/material.dart';
import 'package:teste/classes/questionClass.dart';

QuestionClass questionClassInstance = QuestionClass();
bool hasData = false;

class Question extends StatefulWidget{
  final String questionType;//o tipo de lista de questão, se é geral, matéria, tópico ou subtópico
  final List questionFilter;//a lista com todas as matérias, tópicos ou subtópicos
  final int quantity;
  final String dificulty;
  final String questionsContext;

  const Question({Key? key, required this.questionType, required this.questionFilter, required this.quantity, required this.dificulty, required this.questionsContext}) : super(key: key);
  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Aqui deve-se ficar a questão e o looping entre elas")));
  }
}