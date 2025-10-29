import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "http://10.0.2.2:3000";

Future <dynamic> getQuestionConnection(subject, topic, subTopic, difficulty, searchType, howMany) async {
  try {
    final url = Uri.parse("$baseUrl/question/getquestion");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'credentials':'include'},
      body: jsonEncode({
        "subject": subject, 
        "topic": topic,
        "subTopic": subTopic,
        "difficulty":difficulty,
        "searchType":searchType,
        "howMany":howMany
      }),
    );

    final responseBody = jsonDecode(res.body);

    return responseBody;

  } catch (error) {
    return {"error":"error"};
  }
}