import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:muto_system/connections/credentialConnection.dart';

Future<Map<String, dynamic>> getUserBasicDataConnection() async {
  try {
    final url = Uri.parse("$baseUrl/basicdata/userbasicdata");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({}),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body['message'] ?? {}; // ✅ garante retorno tipo Map
    } else {
      print("Erro HTTP: ${res.statusCode}");
      return {};
    }
  } catch (error) {
    print("Erro em getUserBasicDataConnection: $error");
    return {};
  }
}