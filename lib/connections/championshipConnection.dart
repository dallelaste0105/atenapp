import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "http://10.0.30.164:3000";

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}

Future<String> createChampionshipConnection(
  name,
  numberPositions,
  subject,
  topic,
  subTopic,
  finalParameter,
  type,
  code
) async {
  try {
    final url = Uri.parse("$baseUrl/credential/signup");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "numberPositions": numberPositions,
        "subject": subject,
        "topic": topic,
        "subTopic": subTopic,
        "code": code
      }),
    );

    final responseBody = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return responseBody['message'] ?? 'Campeonato criado com sucesso.';
    } else {
      return responseBody['message'] ?? 'Erro na criação';
    }
  } catch (error) {
    return "Erro inesperado: $error";
  }
}