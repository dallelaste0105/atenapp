import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/config.dart';
import 'package:teste/connections/sendNotificationsConnection.dart';
import 'package:teste/connections/credentialConnections.dart';
import 'package:teste/views/pages/pageTerminal.dart';
import 'package:teste/views/pages/allPages/signup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<dynamic> login(name, password) async {
    final res = await loginConnection({"name": name, "noEncriptedPassword": password});

    if (res["ok"] == true) {
      String token = res["jwt"];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt', token);
      await Future.delayed(const Duration(milliseconds: 500));
      try {
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          await saveUserFCMToken({"FCMToken": fcmToken});
        } 
      } catch (e) {
        // Erro silencioso ou log interno se necessário
      }

      if (res["msg"] == "user") {
        return Navigator.push(context, MaterialPageRoute(builder: (context) => UserPageView()));
      } else if (res["msg"] == "student") {
        return Navigator.push(context, MaterialPageRoute(builder: (context) => StudentPageView()));
      } else if (res["msg"] == "teacher") {
        return Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherPageView()));
      } else if (res["msg"] == "school") {
        return Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolPageView()));
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res["msg"]), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ConfigClass>(context);
    return Scaffold(
      backgroundColor: config.secundaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(labelText: "Nome", filled: true, fillColor: Colors.white),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: password,
                decoration: InputDecoration(labelText: "Senha", filled: true, fillColor: Colors.white),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async { await login(name.text, password.text); },
                child: Text("Login")
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: config.primaryColor),
                onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => Signup())); },
                child: const Text("Fazer signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}