import 'connectionFunctions.dart';

getQuestionsConnection(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("post", "question/getquestions", body);
}

finalAnswerConnection(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("post", "question/finalanswer", body);
}