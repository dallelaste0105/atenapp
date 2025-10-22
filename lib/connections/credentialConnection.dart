import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = "http://localhost:3000";

Future<Map<String, dynamic>> signupCredentialConnection(
  String name,
  String email,
  String password,
  String schoolname,
  String cod,
  String userType,
) async {
  final url = Uri.parse('$baseUrl/credential/signup');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'schoolname': schoolname,
        'cod': cod,
        'userType': userType,
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return {'success': true, 'data': body};
    } else {
      final body = jsonDecode(response.body);
      return {
        'success': false,
        'message': body['message'] ?? 'Erro desconhecido',
      };
    }
  } catch (e) {
    print('Erro na requisição de cadastro: $e');
    return {'success': false, 'message': 'Erro de conexão com o servidor'};
  }
}

Future<Map<String, dynamic>> loginCredentialConnection(
  String name,
  String password,
  String userType,
) async {
  final url = Uri.parse('$baseUrl/credential/login');

  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'password': password,
        'userType': userType,
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return {'success': true, 'data': body};
    } else {
      final body = jsonDecode(response.body);
      return {
        'success': false,
        'message': body['message'] ?? 'Erro desconhecido',
      };
    }
  } catch (e) {
    print('Erro na requisição de login: $e');
    return {'success': false, 'message': 'Erro de conexão com o servidor'};
  }
}
