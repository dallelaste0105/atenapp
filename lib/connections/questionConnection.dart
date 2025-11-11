import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "http://10.0.30.164:3000";

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}

Future <dynamic> getQuestionConnection(subTopic, difficulty, howMany) async {
  try {
    final jwtToken = await getToken();

    final url = Uri.parse("$baseUrl/question/getquestion");

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({
        "subTopic": subTopic,
        "difficulty":difficulty,
        "howMany":howMany
      }),
    );

    final responseBody = jsonDecode(res.body);

    return responseBody;

  } catch (error) {
    return {"error":"error"};
  }
}

Future <dynamic> addPointsContextConnection(context, accuracy) async {
  try {
    final jwtToken = await getToken();
    final url = Uri.parse("$baseUrl/question/addpoints");

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({
        "context": context,
        "accuracy": accuracy,
      }),
    );

    final responseBody = jsonDecode(res.body);

    return responseBody;

  } catch (error) {
    return {"error":"error"};
  }
}

Future <dynamic> getQuestionInfoConnection() async {
  try {
    final jwtToken = await getToken();

    final url = Uri.parse("$baseUrl/question/getquestioninfo");

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({}),
    );

    final responseBody = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return responseBody['message'] ?? 'Requisição realizada com sucesso.';
    } else {
      return responseBody['message'] ?? 'Erro na requisição.';
    }

  } catch (error) {
    return {"sexo1":"sexo2"};
  }
}