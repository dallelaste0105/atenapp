import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste/config.dart';
import 'package:teste/connections/credentialConnections.dart';
import 'package:teste/views/pages/allPages/config.dart';
import 'package:teste/views/pages/allPages/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController code = TextEditingController();

  Future<dynamic> signup(name, password, code) async{
    final res = await signupConnection({"name":name, "noEncriptedPassword":password, "code":code});
    if (res["ok"]==true) {
      return 
        Login();
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
              
              TextField(
                controller: code,
                decoration: InputDecoration(
                  labelText: "Código", 
                  filled: true, 
                  fillColor: Colors.white.withOpacity(0.9)
                ),
              ),
              
              const SizedBox(height: 20),
              
              ElevatedButton(onPressed: () async {await signup(name.text, password.text, code.text);}, child: Text("Signup")),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: config.primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => Login())
                  );
                },
                child: const Text("Fazer login"))
            ],
          ),
        ),
      ),
    );
  }
}