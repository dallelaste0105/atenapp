import 'package:flutter/material.dart';

class QuestionFilterWidget extends StatefulWidget {
  @override
  State<QuestionFilterWidget> createState() => _QuestionFilterWidgetState();
}

class _QuestionFilterWidgetState extends State<QuestionFilterWidget> {
  String? selectedValue; 
  List<String> items = ['Fácil', 'Médio', 'Difícil']; 
  
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      hint: Text('Selecione uma dificuldade'),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedValue = newValue!;
        });
      },
    );
  }
}
