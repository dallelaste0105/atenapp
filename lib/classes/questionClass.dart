import 'package:muto_system/connections/questionConnection.dart';

class QuestionClass {
  List<dynamic> questionsList = [];
  List<String> accuracy = [];
  Map<String, dynamic> questionInfo = {};

  Future<void> takeSaveQuestionDataFunction(subTopic, difficulty, howMany) async {
    final dynamic questionsData =
        await getQuestionConnection(subTopic, difficulty, howMany);

    if (questionsData is Map<String, dynamic> &&
        questionsData.containsKey("message") &&
        questionsData["message"] is List) {
      questionsList = questionsData["message"] as List<dynamic>;
    } else if (questionsData is List<dynamic>) {
      questionsList = questionsData;
    } else {
      questionsList = [];
    }
  }

  dynamic showFirstQuestion() {
    if (questionsList.isEmpty) return null;
    return questionsList[0];
  }

  void excludeFirstQuestion() {
    if (questionsList.isNotEmpty) {
      questionsList.removeAt(0);
    }
  }

  void verifyAccuracy(String answer) {
    if (questionsList.isNotEmpty &&
        answer == questionsList[0]["correctAnswer"]) {
      accuracy.add(questionsList[0]["difficulty"].toString());
    }
  }

  /// ✅ Agora o parâmetro é "contextType", não o BuildContext do Flutter
  Future<void> addPointsContext(String contextType) async {
    await addPointsContextConnection(contextType, accuracy);
  }

  Future<void> getQuestionInfo() async {
    questionInfo = await getQuestionInfoConnection();
  }

  Future<Map<String, dynamic>> showQuestionInfo() async {
    return questionInfo;
  }
}
