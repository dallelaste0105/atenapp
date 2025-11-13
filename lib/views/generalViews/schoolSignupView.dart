import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:muto_system/connections/credentialConnection.dart';
import 'package:muto_system/views/generalViews/signupView.dart';
import 'package:muto_system/views/userViews/leagueView/leaguePositionsView.dart';

class schoolCredentialView extends StatefulWidget {
  const schoolCredentialView({super.key});

  @override
  State<schoolCredentialView> createState() => _schoolCredentialViewState();
}

class _schoolCredentialViewState extends State<schoolCredentialView> {
  final TextEditingController name = TextEditingController();
  final TextEditingController schoolCode = TextEditingController();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController teacherCode = TextEditingController();
  final TextEditingController studentCode = TextEditingController();

  void showSnack(String message, bool success) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/img/logoAtena.png", width: 175),
                  TextField(
                    controller: name,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "NOME",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: "EMAIL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "SENHA",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: teacherCode,
                    decoration: InputDecoration(
                      labelText: "CÓDIGO DOS PROFESSORES",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: studentCode,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "CÓDIGO DOS ALUNOS",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Botão login
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: () {
                        debugPrint("tentando cadastro");
                      },
                      child: const Text(
                        "Cadastrar-se",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final SignUpAnswer =
                            await schoolSignupCredentialConnection(
                              name.text,
                              email.text,
                              password.text,
                              schoolCode.text,
                              teacherCode.text,
                              studentCode.text,
                            );

                        switch (SignUpAnswer) {
                          case "200":
                            showSnack(SignUpAnswer, true);
                            break;
                          case "500":
                            showSnack(SignUpAnswer, false);
                            break;
                          default:
                            showSnack('Algo deu errado', false);
                        }
                      } catch (e) {
                        showSnack('Erro inesperado: $e', false);
                      }
                    },
                    child: Text("BOTÂO DO DALLE LASTE"),
                  ),

                  SizedBox(height: 15),
                  // Cadastro
                  RichText(
                    text: TextSpan(
                      text: "Você já tem uma conta? ",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        TextSpan(
                          text: "Entre com ela",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.blue, // cor de link
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LeagueScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CredentialView(),
                        ),
                      );
                    },
                    child: Text("Para usuários"),
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