import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> signupCredentialConnection(name, email, password, schoolName, yourCode) async {
  try {
    final url = Uri.parse("http://localhost:3000/credential/signup");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "schoolName": schoolName,
        "yourCode": yourCode,
      }),
    );

    final responseBody = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return responseBody['message'];
    } else {
      return responseBody['message'] ?? 'Erro inesperado no servidor';
    }
  } catch (error) {
    return "Erro inesperado $error";
  }
}


Future<String> loginCredentialConnection(name, password, userType) async {
  try {
    final url = Uri.parse("http://localhost:3000/credential/signup");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "password": password,
        "userType": userType
      }),
    );

    final responseBody = jsonDecode(res.body);

    return responseBody.message;
    }
   catch (error) {
    return "Erro inesperado $error";
  }
}