import 'package:muto_system/connections/questionConnection.dart';
import 'package:flutter/material.dart';

class QuestionClass {

  List<dynamic> questionsList = [];

  Future<void> takeSaveQuestionDataFunction(subject, topic, subTopic, difficulty, searchType, howMany) async {
    final List<dynamic> questions = await getQuestionConnection(subject, topic, subTopic, difficulty, searchType, howMany);
    questionsList.add(questions);
  }

  Future<dynamic> showFirstQuestion() async {
    return questionsList[0]["subject"];
  }

  Future<void> excludeFirstQuestion() async {
    questionsList.removeAt(0);
  }

}

/*void main() {
  Map<String, dynamic> question1 = {
    "id": 1,
    "subject": "mat",
    "topic": "matbas",
    "subTopic": "matbasadi",
    "difficulty": 1,
    "question": "Quanto é 3 + 5?",
    "correctOption": "A",
  };

  Map<String, dynamic> question2 = {
    "id": 1,
    "subject": "mat",
    "topic": "matbas",
    "subTopic": "matbasadi",
    "difficulty": 1,
    "question": "Quanto é 3 + 5?",
    "correctOption": "A",
  };

  Map<String, dynamic> question3 = {
    "id": 1,
    "subject": "port",
    "topic": "matbas",
    "subTopic": "matbasadi",
    "difficulty": 1,
    "question": "Quanto é 3 + 5?",
    "correctOption": "A",
  };

  List<dynamic> questions = [question1, question2, question3];

  print(questions[2]["subject"]);
}*/