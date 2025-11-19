import 'package:Atena/connections/connectionsConfig.dart';

Future<dynamic> getQuestionConnection(subTopic, difficulty, howMany) async {
  return await defaultConnection(
    "/question/getquestion",
    "POST",
    body: {
      "subTopic": subTopic,
      "difficulty": difficulty,
      "howMany": howMany
    },
  );
}

Future<dynamic> addPointsContextConnection(context, accuracy) async {
  return await defaultConnection(
    "/question/addpoints",
    "POST",
    body: {
      "context": context,
      "accuracy": accuracy,
    },
  );
}

Future<dynamic> getQuestionInfoConnection() async {
  return await defaultConnection(
    "/question/getquestioninfo",
    "POST",
    body: {},
  );
}