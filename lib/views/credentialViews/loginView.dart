import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:muto_system/views/credentialViews/signupView.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/views/homeView/homeView.dart';

class CredentialViewLogin extends StatefulWidget {
  const CredentialViewLogin({super.key});

  @override
  State<CredentialViewLogin> createState() => _CredentialViewLoginState();
}

class _CredentialViewLoginState extends State<CredentialViewLogin> {
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
                    decoration: InputDecoration(
                      labelText: "EMAIL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "SENHA",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

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
                      onPressed: () {
                        debugPrint("tentando logar");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeView(token: '',)),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Botão Google
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: OutlinedButton.icon(
                  //     icon: Image.asset(
                  //       "assets/icons/GoogleLogo.png",
                  //       height: 25,
                  //     ),
                  //     label: const Text(
                  //       "Login com o Google",
                  //       style: TextStyle(fontSize: 24),
                  //     ),
                  //     style: OutlinedButton.styleFrom(
                  //       padding: const EdgeInsets.symmetric(vertical: 14),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //     ),
                  //     onPressed: () async {
                  //       final user = await GoogleAuthService()
                  //           .signInWithGoogle();
                  //       if (user != null) {
                  //         debugPrint("Usuário logado: ${user.displayName}");
                  //         // Navigator.of(context).pushReplacement(
                  //         //   MaterialPageRoute(builder: (context) => HomeScreen()),
                  //         // );
                  //       } else {
                  //         debugPrint("Login falhou ou foi cancelado.");
                  //       }
                  //     },
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
                                  builder: (context) => CredentialView(),
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
