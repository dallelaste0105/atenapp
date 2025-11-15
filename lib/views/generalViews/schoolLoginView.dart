import 'package:Atena/views/generalViews/schoolSignupView.dart';
import 'package:Atena/views/generalViews/userSignupView.dart';
import 'package:Atena/views/pageViews.dart';
import 'package:flutter/material.dart';
import 'package:Atena/connections/credentialConnection.dart';
import 'package:Atena/views/userViews/configView/colorConfigView.dart';

class SchoolLoginView extends StatefulWidget {
  @override
  State<SchoolLoginView> createState() => _SchoolLoginViewState();
}

class _SchoolLoginViewState extends State<SchoolLoginView> {

  TextEditingController name = TextEditingController();
  TextEditingController password= TextEditingController();


Future<void> login () async {
  String signupStatus = await schoolLoginCredentialConnection(name.text, password.text);
    if (signupStatus == "Escola fez login com sucesso") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserPageView()));
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
          

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () { login(); },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tertiaryColor,
                    foregroundColor: secondaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 6,
                  ),
                  child: const Text("Login"),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolSignupView()));
                  },
                  child: Text(
                    "Não tenho conta",
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