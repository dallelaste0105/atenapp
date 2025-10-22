import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:muto_system/connections/credentialConnection.dart';
import 'package:muto_system/views/userViews/credentialViews/loginView.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;

class CredentialView extends StatefulWidget {
  const CredentialView({super.key});

  @override
  State<CredentialView> createState() => _CredentialViewState();
}

class _CredentialViewState extends State<CredentialView> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController schoolname = TextEditingController();
  final TextEditingController cod = TextEditingController();

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
        backgroundColor: ThemeColors.Colors.background_black,
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
                    controller: schoolname,
                    decoration: InputDecoration(
                      labelText: "NOME DA ESCOLA",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: cod,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "SEU CÓDIGO",
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
                        backgroundColor: ThemeColors.Colors.background_black,
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
                        final SignUpAnswer = await signupCredentialConnection(
                          name.text,
                          email.text,
                          password.text,
                          schoolname.text,
                          cod.text,
                          '',
                        );

                        switch (SignUpAnswer) {
                          // ignore: constant_pattern_never_matches_value_type
                          case "Campos obrigatórios faltando!":
                            showSnack(SignUpAnswer as String, false);
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
                                  builder: (context) => CredentialViewLogin(),
                                ),
                              );
                            },
                        ),
                      ],
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
