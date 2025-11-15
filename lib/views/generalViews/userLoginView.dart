import 'package:Atena/views/generalViews/schoolSignupView.dart';
import 'package:Atena/views/generalViews/userSignupView.dart';
import 'package:Atena/views/pageViews.dart';
import 'package:flutter/material.dart';
import 'package:Atena/connections/credentialConnection.dart';
import 'package:Atena/views/userViews/configView/colorConfigView.dart';

class UserLoginView extends StatefulWidget {
  @override
  State<UserLoginView> createState() => _UserLoginViewState();
}

class _UserLoginViewState extends State<UserLoginView> {

  TextEditingController name = TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController userType = TextEditingController();
  String? selectedUserType;


Future<void> login () async {
  String signupStatus = await loginCredentialConnection(name.text, password.text, userType.text);
    if (signupStatus == "userLogin") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserPageView()));
    }
    else if (signupStatus == "studentLogin") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentPageView()));
    }
    else if (signupStatus == "teacherLogin") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherPageView()));
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
                 // estado para o dropdown

                DropdownButtonFormField<String>(
                  value: selectedUserType,
                  items: const [
                    DropdownMenuItem(value: "user", child: Text("Usuário")),
                    DropdownMenuItem(value: "student", child: Text("Estudante")),
                    DropdownMenuItem(value: "teacher", child: Text("Professor")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedUserType = value;   // atualiza o dropdown
                      userType.text = value ?? ""; // atualiza o controller
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Tipo de usuário",
                    labelStyle: TextStyle(color: tertiaryColor),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tertiaryColor),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: quinternaryColor, width: 2),
                    ),
                  ),
                  dropdownColor: secondaryColor,
                  style: TextStyle(color: primaryColor),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolSignupView()));
                  },
                  child: Text(
                    "Sou escola",
                    style: TextStyle(color: tertiaryColor),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserSignupView()));
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