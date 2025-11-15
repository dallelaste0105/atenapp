import 'package:Atena/views/generalViews/schoolLoginView.dart';
import 'package:Atena/views/generalViews/userLoginView.dart';
import 'package:Atena/views/generalViews/userSignupView.dart';
import 'package:flutter/material.dart';
import 'package:Atena/connections/credentialConnection.dart';
import 'package:Atena/views/userViews/configView/colorConfigView.dart';

class SchoolSignupView extends StatefulWidget {
  @override
  State<SchoolSignupView> createState() => _SchoolSignupViewState();
}

class _SchoolSignupViewState extends State<SchoolSignupView> {

  TextEditingController name = TextEditingController();
  TextEditingController schoolCode = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController teacherCode = TextEditingController();
  TextEditingController studentCode = TextEditingController();


Future<void> signup () async {
  String signupStatus = await schoolSignupCredentialConnection(name.text, email.text, password.text, schoolCode.text, teacherCode.text, studentCode.text);
    if (signupStatus == "Escola se cadastrou com sucesso") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolLoginView()));
    }
    else {
      showModalBottomSheet(context: context, builder: (context) { return Container( padding: EdgeInsets.all(20), child: Text(signupStatus));});
      }
    }


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: quinternaryColor, 
    body: Center(
      child: SingleChildScrollView(
        child: Card(
          color: secondaryColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logoWithoutBackground.png',
                  height: 120,
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: name,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(color: tertiaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tertiaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: quinternaryColor, width: 2),
                    ),
                  ),
                ),
                TextField(
                  controller: email,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: tertiaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tertiaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: quinternaryColor, width: 2),
                    ),
                  ),
                ),
                TextField(
                  controller: password,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    labelText: "Senha",
                    labelStyle: TextStyle(color: tertiaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tertiaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: quinternaryColor, width: 2),
                    ),
                  ),
                ),
                TextField(
                  controller: name,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    labelText: "Nome",
                    labelStyle: TextStyle(color: tertiaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tertiaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: quinternaryColor, width: 2),
                    ),
                  ),
                ),
                TextField(
                  controller: studentCode,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    labelText: "Código de estudante",
                    labelStyle: TextStyle(color: tertiaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tertiaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: quinternaryColor, width: 2),
                    ),
                  ),
                ),
                TextField(
                  controller: teacherCode,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    labelText: "Código de professor",
                    labelStyle: TextStyle(color: tertiaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tertiaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: quinternaryColor, width: 2),
                    ),
                  ),
                ),
                TextField(
                  controller: schoolCode,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    labelText: "Código da escola",
                    labelStyle: TextStyle(color: tertiaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tertiaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: quinternaryColor, width: 2),
                    ),
                  ),
                ),
                

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () { signup(); },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tertiaryColor,
                    foregroundColor: secondaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 6,
                  ),
                  child: const Text("Sign Up"),
                ),

                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserSignupView()));
                  },
                  child: Text(
                    "Sou aluno",
                    style: TextStyle(color: tertiaryColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolLoginView()));
                  },
                  child: Text(
                    "Já tenho conta",
                    style: TextStyle(color: tertiaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


}