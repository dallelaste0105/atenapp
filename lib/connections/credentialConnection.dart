import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

const String baseUrl = "http://192.168.1.2:3000";

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

Future<String> signupCredentialConnection(
  name,
  email,
  password,
  schoolName,
  yourCode,
) async {
  try {
    final url = Uri.parse("$baseUrl/credential/signup");

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
      return responseBody['message'] ?? 'Usuário cadastrado com sucesso.';
    } else {
      return responseBody['message'] ?? 'Erro no cadastro.';
    }
  } catch (error) {
    return "Erro inesperado: $error";
  }
}

Future<String> loginCredentialConnection(name, password, userType) async {
  try {
    final url = Uri.parse("$baseUrl/credential/login");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "password": password,
        "userType": userType,
      }),
    );

    final responseBody = jsonDecode(res.body);

    if (res.statusCode == 200) {
      final token = responseBody['token'];
      if (token is String) {
        await saveTokenCredentialConnection(token);
      }
      return responseBody['message'] ?? 'Login realizado com sucesso.';
    } else {
      return responseBody['message'] ?? 'Erro no login.';
    }
  } catch (error) {
    return "Erro inesperado: $error";
  }
}

Future<String> schoolSignupCredentialConnection(
  name,
  email,
  password,
  schoolCode,
  teacherCode,
  studentCode,
) async {
  try {
    final url = Uri.parse("$baseUrl/credential/schoolsignup");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "schoolCode": schoolCode,
        "teacherCode": teacherCode,
        "studentCode": studentCode,
      }),
    );

    final responseBody = jsonDecode(res.body);

    if (res.statusCode == 200) {
      return responseBody['message'] ?? 'Escola cadastrada com sucesso.';
    } else {
      return responseBody['message'] ?? 'Erro no cadastro da escola.';
    }
  } catch (error) {
    return "Erro inesperado: $error";
  }
}

Future<String> schoolLoginCredentialConnection(name, password) async {
  try {
    final url = Uri.parse("$baseUrl/credential/schoollogin");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"name": name, "password": password}),
    );

    final responseBody = jsonDecode(res.body);

    if (res.statusCode == 200) {
      final token = responseBody['token'];
      if (token is String) {
        await saveTokenCredentialConnection(token);
      }
      return responseBody['message'] ??
          'Login da escola realizado com sucesso.';
    } else {
      return responseBody['message'] ?? 'Erro no login da escola.';
    }
  } catch (error) {
    return "Erro inesperado: $error";
  }
}

