import 'package:Atena/views/generalViews/schoolLoginView.dart';
import 'package:Atena/views/generalViews/userSignupView.dart';
import 'package:flutter/material.dart';
import 'package:Atena/connections/credentialConnection.dart';

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

  Future<void> signup() async {
    String signupStatus = await schoolSignupCredentialConnection(
      name.text,
      email.text,
      password.text,
      schoolCode.text,
      teacherCode.text,
      studentCode.text,
    );

    if (signupStatus == "Escola se cadastrou com sucesso") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolLoginView()));
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(20),
          child: Text(signupStatus),
        ),
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
                  buildField("Email", email, cs),
                  buildField("Senha", password, cs, obscure: true),
                  buildField("Código de estudante", studentCode, cs),
                  buildField("Código de professor", teacherCode, cs),
                  buildField("Código da escola", schoolCode, cs),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cs.tertiary,
                      foregroundColor: cs.secondary,
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
                    child: Text("Sou aluno", style: TextStyle(color: cs.tertiary)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolLoginView()));
                    },
                    child: Text("Já tenho conta", style: TextStyle(color: cs.tertiary)),
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
