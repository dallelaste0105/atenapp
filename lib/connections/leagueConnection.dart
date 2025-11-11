import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "http://10.0.30.164:3000";

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}

Future<List> getCompetitorsLeagueConnection() async {
  try {
    final jwtToken = await getToken();

    if (jwtToken == null || jwtToken.isEmpty) {
      return ["Erro: Usuário não autenticado. Faça login primeiro."];
    }

    final url = Uri.parse("$baseUrl/league/getcompetitorsleague");

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
    return ["Erro inesperado: $error"];
  }
}