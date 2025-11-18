import 'dart:convert';
import 'package:Atena/connections/credentialConnection.dart';
import 'package:Atena/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future <dynamic> createChampionship(name, participantcode, admcode) async {
  try {
    final jwtToken = await getToken();

    final url = Uri.parse("$baseUrl/championship/createchampionship");

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({
        "name":name,
        "participantcode":participantcode,
        "admcode":admcode
      }),
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

Future <dynamic> searchChampionship(name) async {
  try {
    final jwtToken = await getToken();

    final url = Uri.parse("$baseUrl/championship/searchchampionship");

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({
        "name":name
      }),
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

Future <dynamic> enterChampionship(name, code) async {
  try {
    final jwtToken = await getToken();

    final url = Uri.parse("$baseUrl/championship/enterchampionship");

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({
        "name":name,
        "code":code
      }),
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

Future <dynamic> creatEvent(championshipid, name, finishdate, type) async {
  try {
    final jwtToken = await getToken();

    final url = Uri.parse("$baseUrl/championship/createvent");

    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
      body: jsonEncode({
        "championshipid":championshipid,
        "name":name,
        "finishdate":finishdate,
        "type":type
      }),
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

Future <dynamic> getChampionships() async {
  try {
    final jwtToken = await getToken();

    final url = Uri.parse("$baseUrl/championship/getchampionships");

    final res = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
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