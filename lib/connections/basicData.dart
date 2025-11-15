import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Atena/connections/credentialConnection.dart';

Future<Map<String, dynamic>> getUserBasicDataConnection() async {
  try {
    final jwtToken = await getToken();
    final url = Uri.parse("$baseUrl/basicdata/userbasicdata");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json', 'Authorization': 'Bearer $jwtToken'},
      body: jsonEncode({}),
    );

    if (res.statusCode == 200) {
      final body = jsonDecode(res.body);
      return body['message'] ?? {}; 
    } else {
      print("Erro HTTP: ${res.statusCode}");
      return {};
    }
  } catch (error) {
    print("Erro em getUserBasicDataConnection: $error");
    return {};
  }
}