import 'package:Atena/views/generalViews/schoolSignupView.dart';
import 'package:Atena/views/generalViews/userSignupView.dart';
import 'package:Atena/views/pageViews.dart';
import 'package:flutter/material.dart';
import 'package:Atena/connections/credentialConnection.dart';

class UserLoginView extends StatefulWidget {
  @override
  State<UserLoginView> createState() => _UserLoginViewState();
}

class _UserLoginViewState extends State<UserLoginView> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController userType = TextEditingController();
  String? selectedUserType;

  Future<void> login() async {
    String signupStatus =
        await loginCredentialConnection(name.text, password.text, userType.text);

    if (signupStatus == "userLogin") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserPageView()));
    } else if (signupStatus == "studentLogin") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentPageView()));
    } else if (signupStatus == "teacherLogin") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherPageView()));
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(padding: EdgeInsets.all(20), child: Text(signupStatus)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            color: cs.secondary,
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/logoWithoutBackground.png', height: 120),
                  const SizedBox(height: 20),

                  buildField("Nome", name, cs),
                  buildField("Senha", password, cs, obscure: true),

                  DropdownButtonFormField<String>(
                    value: selectedUserType,
                    items: const [
                      DropdownMenuItem(value: "user", child: Text("Usuário")),
                      DropdownMenuItem(value: "student", child: Text("Estudante")),
                      DropdownMenuItem(value: "teacher", child: Text("Professor")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedUserType = value;
                        userType.text = value ?? "";
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Tipo de usuário",
                      labelStyle: TextStyle(color: cs.tertiary),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: cs.tertiary)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: cs.primary, width: 2)),
                    ),
                    dropdownColor: cs.secondary,
                    style: TextStyle(color: cs.primary),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.tertiary,
                      foregroundColor: cs.secondary,
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
                    child: Text("Sou escola", style: TextStyle(color: cs.tertiary)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserSignupView()));
                    },
                    child: Text("Não tenho conta", style: TextStyle(color: cs.tertiary)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller, ColorScheme cs, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      style: TextStyle(color: cs.primary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: cs.tertiary),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: cs.tertiary)),
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: cs.primary, width: 2)),
      ),
    );
  }
}
