import 'dart:convert';
import 'package:Atena/connections/credentialConnection.dart';
import 'package:Atena/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future <dynamic> createChampionshipConnection() async {
  try {
    final jwtToken = await getToken();

    final url = Uri.parse("$baseUrl/question/getquestioninfo");

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
    } 
    else if (res.statusCode == 401 || res.statusCode == 403) {
      
      await deleteToken(); 

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login', (Route<dynamic> route) => false);
      
      return []; 
    }
    else {
      return responseBody['message'] ?? 'Erro na requisição.';
    }

  } catch (error) {
    return {"sexo1":"sexo2"};
  }
}