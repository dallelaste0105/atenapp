import 'package:Atena/views/generalViews/schoolSignupView.dart';
import 'package:Atena/views/generalViews/userLoginView.dart';
import 'package:flutter/material.dart';
import 'package:Atena/connections/credentialConnection.dart';
import 'package:Atena/views/userViews/configView/colorConfigView.dart';

class UserSignupView extends StatefulWidget {
  @override
  State<UserSignupView> createState() => _UserSignupViewState();
}

class _UserSignupViewState extends State<UserSignupView> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController schoolName = TextEditingController();
  TextEditingController code = TextEditingController();


Future<void> signup () async {
  String signupStatus = await signupCredentialConnection(name.text, email.text, password.text, schoolName.text, code.text);
    if (signupStatus == "Usuário cadastrado com sucesso!") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserSignupView()));
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
                  obscureText: true,
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
                  controller: schoolName,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    labelText: "Nome da escola",
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
                  controller: code,
                  style: TextStyle(color: primaryColor),
                  decoration: InputDecoration(
                    labelText: "Código",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolSignupView()));
                  },
                  child: Text(
                    "Sou escola",
                    style: TextStyle(color: tertiaryColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserLoginView()));
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