import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/main.dart';
import 'package:teste/views/pages/allPages/login.dart';
import 'package:teste/views/pages/allPages/netError.dart';

bool _isShowingNetError = false;

final dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ),
);

final baseUrl = "http://192.168.1.2:3000/";

Future<Map<String, dynamic>> simpleFeedBackConnection(
  String type,
  String route,
  Map<String, dynamic> body,
) async {
  try {
    final token = await getJWT();

    final options = Options(
      headers: {
        "Content-Type": "application/json",
        if (token != null && token.isNotEmpty) "Authorization": "Bearer $token",
      },
    );

    Response res;

    if (type == "get") {
      res = await dio.get("$baseUrl$route", options: options);
    } else {
      res = await dio.post(
        "$baseUrl$route",
        data: body,
        options: options,
      );
    }

    return res.data;
  } on DioException catch (e) {
    if ((e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.connectionError) &&
        !_isShowingNetError) {
      _isShowingNetError = true;

      navigatorKey.currentState
          ?.push(MaterialPageRoute(builder: (_) => NetError()))
          .then((_) {
        _isShowingNetError = false;
      });

      return {"ok": false, "networkError": true};
    }

    if (e.response?.statusCode == 401) {
      final sp = await SharedPreferences.getInstance();
      await sp.remove("jwt");

      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Login()),
        (_) => false,
      );

      return {"ok": false, "unauthorized": true};
    }

    return e.response?.data ?? {"ok": false, "msg": "Erro inesperado"};
  }
}

Future<void> saveJWT(String jwt) async {
  final sp = await SharedPreferences.getInstance();
  await sp.setString("jwt", jwt.trim());
}

Future<String?> getJWT() async {
  final sp = await SharedPreferences.getInstance();
  await sp.reload();
  final token = sp.getString("jwt");
  return token?.trim();
}

verifyUserFCMToken(Map<String, dynamic> body) async {
  return await simpleFeedBackConnection("get", "credential/verifyuserfcmtoken", body);
}

saveUserFCMToken(Map<String, dynamic> body) async {
  return await simpleFeedBackConnection("post", "credential/saveuserfcmtoken", body);
}