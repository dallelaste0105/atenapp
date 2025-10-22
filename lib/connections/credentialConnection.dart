import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = "http://localhost:3000";

Future<String> signupCredentialConnection(name, email, password, schoolName, yourCode) async {
  try {
    final url = Uri.parse("$baseUrl/credential/schoolsignup");

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
    final url = Uri.parse("$baseUrl/credential/schoolsignup");

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
      return responseBody['message'];
    } else {
      return responseBody['message'] ?? 'Erro inesperado no servidor';
    }
  } catch (error) {
    return "Erro inesperado $error";
  }
}

Future<String> schoolSignupCredentialConnection(name, email, password, schoolCode, teacherCode, studentCode) async {
  try {
    final url = Uri.parse("$baseUrl/credential/schoolsignup");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "schoolCode":schoolCode,
        "teacherCode": teacherCode,
        "studentCode": studentCode,
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

Future<String> schoolLoginCredentialConnection(name, password) async {
  try {
    final url = Uri.parse("$baseUrl/credential/schoollogin");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "password": password,
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
