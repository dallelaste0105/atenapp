import 'dart:convert';
import 'package:Atena/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final baseUrl = "http://10.0.30.164:3000";

Future<void> saveTokenCredentialConnection(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}

Future<void> deleteToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("token");
}

Future<dynamic> defaultConnection(
  String connectionUrl,
  String method, {
  Map<String, dynamic>? body,
  bool requireAuth = true,
}) async {
  try {
    final url = Uri.parse("$baseUrl$connectionUrl");

    String? jwt = requireAuth ? await getToken() : null;

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      if (jwt != null) 'Authorization': 'Bearer $jwt',
    };

    late http.Response res;

    switch (method.toUpperCase()) {
      case "GET":
        res = await http.get(url, headers: headers);
        break;

      case "POST":
        res = await http.post(
          url,
          headers: headers,
          body: jsonEncode(body ?? {}),
        );
        break;

      case "PUT":
        res = await http.put(
          url,
          headers: headers,
          body: jsonEncode(body ?? {}),
        );
        break;

      case "DELETE":
        res = await http.delete(
          url,
          headers: headers,
          body: jsonEncode(body ?? {}),
        );
        break;

      default:
        return "Método HTTP inválido.";
    }

    final response = jsonDecode(res.body);

    if (res.statusCode == 401 || res.statusCode == 403) {
      await deleteToken();
      navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (_) => false);
      return {"error": "Unauthorized"};
    }

    if (response is Map && response.containsKey("token")) {
      return response;
    }
    return response["message"] ?? response;

  } catch (e) {
    return {"error": "$e"};
  }
}
