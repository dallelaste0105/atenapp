import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muto_system/connections/credentialConnection.dart';

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