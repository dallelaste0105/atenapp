import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/config.dart';
import 'package:teste/connections/connectionFunctions.dart';
import 'package:teste/connections/credentialConnections.dart';
import 'package:teste/views/pages/pageTerminal.dart';
import 'package:teste/views/pages/allPages/signup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController code = TextEditingController();

  Future<dynamic> login(name, password) async{
    final res = await loginConnection({"name":name, "noEncriptedPassword":password});
    if (res["ok"]==true) {
      try {
        final verifyRes = await verifyUserFCMToken({});
        String? savedFCMToken = verifyRes["msg"];
        String? fcmToken = await FirebaseMessaging.instance.getToken();
        print("FCM DO USUÁRIO: $fcmToken");
        if (savedFCMToken!=fcmToken || savedFCMToken==null) {
          await saveUserFCMToken({"FCMToken":fcmToken});
        }
      } catch (e) {
        print("Erro ao obter token FCM: $e");
      }
      return 
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => UserPageView())
        );
    }
    else{
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res["msg"]),
          backgroundColor: const Color.fromARGB(255, 156, 44, 24),
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          elevation: 6,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
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
                decoration: InputDecoration(
                  labelText: "Nome", 
                  filled: true, 
                  fillColor: Colors.white.withOpacity(0.9)
                ),
              ),
              const SizedBox(height: 10),
              
              TextField(
                controller: password,
                decoration: InputDecoration(
                  labelText: "Senha", 
                  filled: true, 
                  fillColor: Colors.white.withOpacity(0.9)
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 20),
              
              ElevatedButton(onPressed: () async {await login(name.text, password.text);}, child: Text("Login")),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: config.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => Signup())
                  );
                },
                child: const Text("Fazer signup"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}