/* import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:muto_system/connections/credentialConnection.dart'; // ADICIONADO
import 'package:muto_system/views/credentialViews/schoolSignupView.dart';
import 'package:muto_system/views/credentialViews/signupView.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/views/homeView/homeView.dart';

// Controllers removidos daqui

class SchoolCredentialViewLogin extends StatefulWidget {
  const SchoolCredentialViewLogin({super.key});

  @override
  State<SchoolCredentialViewLogin> createState() => _SchoolCredentialViewLoginState();
}

class _SchoolCredentialViewLoginState extends State<SchoolCredentialViewLogin> {
  // Controllers movidos para cá (como no seu signup)
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();

  // Função showSnack (copiada do seu signup)
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
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/img/logoAtena.png", width: 150),
                  SizedBox(height: 15),
                  TextField(
                    controller: name, // ADICIONADO
                    decoration: InputDecoration(
                      labelText: "NOME",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: password, // ADICIONADO
                    obscureText: true, // ADICIONADO
                    decoration: InputDecoration(
                      labelText: "SENHA",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Esqueceu senha
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ), // tira o efeito
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Esqueceu a senha?",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ),

                  // Botão login
                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.Colors.background_black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      // LÓGICA DO ONPRESSED ATUALIZADA
                      onPressed: () async {
                        debugPrint("tentando logar");
                        try {
                          // Presumi que a função de login se chame 'loginCredentialConnection'
                          final String loginAnswer =
                              await schoolLoginCredentialConnection(
                            name.text,
                            password.text
                          );

                          switch (loginAnswer) {
                          case "200":
                            showSnack(loginAnswer, true);
                            break;
                          case "500":
                            showSnack(loginAnswer, false);
                            break;
                          default:
                          showSnack('Algo deu errado', false);
                          break;
                        }

                          // Verificamos a resposta
                          // Assumindo que erros são strings curtas e o token (sucesso) é uma string longa
                          if (loginAnswer == "Campos obrigatórios faltando!" ||
                              loginAnswer == "Credenciais inválidas" ||
                              loginAnswer == "Usuário não encontrado") {
                            // Se for um erro conhecido, mostre o snack
                            showSnack(loginAnswer, false);
                          } else if (loginAnswer.length >
                              40) { // Se for uma string longa (token)
                            // Sucesso, navegue para a HomeView
                            // Use pushReplacement para não deixar o usuário voltar para o login
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomeView(token: loginAnswer)),
                            );
                          } else {
                            // Se for qualquer outra resposta inesperada
                            showSnack(
                                loginAnswer.isNotEmpty
                                    ? loginAnswer
                                    : 'Algo deu errado no login',
                                false);
                          }
                        } catch (e) {
                          showSnack('Erro inesperado: $e', false);
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Botão Google (Mantido comentado como no original)
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: OutlinedButton.icon(
                  //     ...
                  //   ),
                  // ),
                  const SizedBox(height: 20),

                  // Cadastro
                  RichText(
                    text: TextSpan(
                      text: "Você não tem uma conta? ",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        TextSpan(
                          text: "Cadastre-se",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => schoolCredentialView(),
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
}*/