import 'package:flutter/material.dart';
import 'package:muto_system/connections/credentialConnection.dart';
import 'package:muto_system/views/generalViews/colorConfigView.dart';

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
      body: Center(child: Card(child: Center(child: Column(children: [
        TextField(controller: name),
        TextField(controller: email),
        TextField(controller: password),
        TextField(controller: schoolName),
        TextField(controller: code),
        ElevatedButton(onPressed: (){signup();}, child: Text("SignUp")),
        GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UserSignupView()));}, child: Text("Sou escola")),
        GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UserSignupView()));}, child: Text("Já tenho conta"))
      ])))
    ), backgroundColor: primaryColor);
  }
}