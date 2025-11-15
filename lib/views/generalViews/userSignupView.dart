import 'package:Atena/views/generalViews/schoolSignupView.dart';
import 'package:Atena/views/generalViews/userLoginView.dart';
import 'package:flutter/material.dart';
import 'package:Atena/connections/credentialConnection.dart';

class UserSignupView extends StatefulWidget {
  @override
  State<UserSignupView> createState() => _UserSignupViewState();
}

class _UserSignupViewState extends State<UserSignupView> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController schoolName = TextEditingController();
  TextEditingController code = TextEditingController();

  Future<void> signup() async {
    String signupStatus =
        await signupCredentialConnection(name.text, email.text, password.text, schoolName.text, code.text);

    if (signupStatus == "Usuário cadastrado com sucesso!") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => UserLoginView()));
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) =>
            Container(padding: EdgeInsets.all(20), child: Text(signupStatus)),
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
                  buildField("Nome da escola", schoolName, cs),
                  buildField("Código", code, cs),

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
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SchoolSignupView())),
                    child: Text("Sou escola", style: TextStyle(color: cs.tertiary)),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserLoginView())),
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
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: cs.primary, width: 2)),
      ),
    );
  }
}
