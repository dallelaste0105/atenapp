import 'package:muto_system/connections/questionConnection.dart';
import 'package:flutter/material.dart';

Future showQuestionScreenFunction(subject, topic, subTopic, difficulty, searchType, howMany) async {
	final List<dynamic> questions = await getQuestionConnection(subject, topic, subTopic, difficulty, searchType, howMany);
	return questions[0] as Map<String, dynamic>;
}


/*
para depois pegar os valores no front:
final Map<String, dynamic> resposta = await showQuestionScreenFunction(
    subject, topic, subTopic, difficulty, searchType, howMany);

print(resposta['subject']);

*/