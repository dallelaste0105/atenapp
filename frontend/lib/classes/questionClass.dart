import 'package:teste/connections/questionConnection.dart';

class QuestionClass {
  Map<String, dynamic> questionData = {};
  int points = 0;

  Future<void> saveQuestionData(questionType, questionFilter, quantity, difficulty) async {
    questionData["questions"] = await getQuestionsConnection({"questionType":questionType, "questionFilter":questionFilter, "quantity":quantity, "difficulty":difficulty});
  }

  void answer(answer, correctAnswer, dificulty){
    if (answer==correctAnswer) {
      int multiplier = 0;
      if(dificulty=="facil"){
        multiplier+=1;
      }
      else if(dificulty=="medio"){
        multiplier+=2;
      }
      else{
        multiplier+=3;
      }
      points+=multiplier;
    }
  }

  void finalAnswer() async {
    await finalAnswerConnection({"points":points});
  }
}