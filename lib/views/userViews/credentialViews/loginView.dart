/*import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:muto_system/views/userViews/credentialViews/signupView.dart';
import 'package:muto_system/configs/colors.dart' as ThemeColors;
import 'package:muto_system/views/userViews/homeView/homeView.dart';
// Importe a função de conexão que você acabou de criar
import 'package:muto_system/connections/credentialConnection.dart';

class CredentialViewLogin extends StatefulWidget {
  const CredentialViewLogin({super.key});

  @override
  State<CredentialViewLogin> createState() => _CredentialViewLoginState();
}

class _CredentialViewLoginState extends State<CredentialViewLogin> {
  // 1. Controladores para os campos de texto
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // 2. Variável para o tipo de usuário (user, student, teacher, school)
  String? selectedUserType = 'user'; // Valor padrão
  List<String> userTypes = ['user', 'student', 'teacher', 'school'];

  // 3. Função para mostrar SnackBar
  void showSnack(String message, bool success) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green : Colors.red,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // 4. Função de Login
  Future<void> _login() async {
    final name = nameController.text.trim();
    final password = passwordController.text;
    final userType = selectedUserType;

    if (name.isEmpty || password.isEmpty || userType == null) {
      showSnack(
        'Por favor, preencha todos os campos e selecione o tipo de usuário.',
        false,
      );
      return;
    }

    showSnack('Tentando logar...', true);

    // Desativar o teclado
    FocusScope.of(context).unfocus();

    final response = await loginCredentialConnection(name, password, userType);

    if (response['success']) {
      showSnack('Login realizado com sucesso!', true);
      // Você pode querer extrair o token do body se o seu controller gerar um JWT
      // Por enquanto, vamos para a HomeView com um token fictício
      final loginData = response['data'];
      String token = 'AQUI_IRIA_UM_TOKEN_JWT_OU_DADOS_DE_SESSAO';
      // Dependendo de como você gera o token no servidor, você precisaria
      // recebê-lo e passá-lo para a HomeView.
      // O seu controller atual não gera JWT, apenas retorna 'message', 'student_id', 'school_id' ou 'teacher_id'.
      // Aqui vou apenas simular o sucesso:

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // No seu HomeView, você precisará adaptar para receber os dados de login.
          // Por exemplo, para um estudante, você passaria o student_id e school_id
          builder: (context) => HomeView(token: token),
        ),
      );
    } else {
      // Mostrar mensagem de erro do servidor
      showSnack(response['message'], false);
    }
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
                  const SizedBox(height: 15),

                  // Campo NOME (Alterado de EMAIL para NOME, baseado no controller Node.js)
                  TextField(
                    controller: nameController, // Adicionado controller
                    decoration: InputDecoration(
                      labelText:
                          "NOME", // O seu controller usa 'name' e não 'email'
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Campo SENHA
                  TextField(
                    controller: passwordController, // Adicionado controller
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "SENHA",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Seletor de TIPO DE USUÁRIO (Adicionado pois é obrigatório no controller Node.js)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedUserType,
                        hint: const Text("Selecione o Tipo de Usuário"),
                        items: userTypes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedUserType = newValue;
                          });
                        },
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
                      onPressed: _login, // Chamada para a função de login
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Botão Google (Comentado, mantido como no original)
                  // SizedBox(...
                  //   ...
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
*/