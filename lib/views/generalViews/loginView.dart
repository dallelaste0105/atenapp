import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/views/generalViews/signupView.dart';
import 'package:muto_system/connections/credentialConnection.dart';
import 'package:muto_system/views/test/testeJwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muto_system/views/testView.dart';

class CredentialViewLogin extends StatefulWidget {
  const CredentialViewLogin({super.key});

  @override
  State<CredentialViewLogin> createState() => _CredentialViewLoginState();
}

class _CredentialViewLoginState extends State<CredentialViewLogin> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? selectedUserType = 'user';
  final List<String> userTypes = ['user', 'student', 'teacher', 'school'];
  bool isLoading = false;

  void showSnack(String message, bool success) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _login() async {
    final name = nameController.text.trim();
    final password = passwordController.text;
    final userType = selectedUserType;

    if (name.isEmpty || password.isEmpty || userType == null) {
      showSnack('Preencha todos os campos.', false);
      return;
    }

    setState(() => isLoading = true);
    FocusScope.of(context).unfocus();

    try {
      final String response = await loginCredentialConnection(
        name,
        password,
        userType,
      );

      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString('token');

      final bool success =
          (savedToken != null && savedToken.isNotEmpty) ||
          response.toLowerCase().contains('sucesso');

      if (!mounted) return;
      setState(() => isLoading = false);

      if (success) {
        showSnack(
          response.isNotEmpty ? response : 'Login realizado com sucesso!',
          true,
        );

        final tokenToSend = savedToken ?? '';

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => UserProfileScreen()),
        );
      } else {
        showSnack(response.isNotEmpty ? response : 'Erro no login.', false);
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      showSnack('Erro ao conectar-se: ${e.toString()}', false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                  const SizedBox(height: 15),

                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "NOME",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "SENHA",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  DropdownButtonFormField<String>(
                    value: selectedUserType,
                    items: userTypes
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(type.toUpperCase()),
                          ),
                        )
                        .toList(),
                    onChanged: (val) => setState(() {
                      selectedUserType = val;
                    }),
                    decoration: InputDecoration(
                      labelText: "TIPO DE USUÁRIO",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.Colors.background_black,
                        foregroundColor: Colors.white,
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "Entrar",
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  RichText(
                    text: TextSpan(
                      text: "Não tem uma conta? ",
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      children: [
                        TextSpan(
                          text: "Cadastre-se",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const CredentialView(),
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
