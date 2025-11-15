import 'package:Atena/views/generalViews/schoolSignupView.dart';
import 'package:Atena/views/generalViews/userSignupView.dart';
import 'package:Atena/views/pageViews.dart';
import 'package:flutter/material.dart';
import 'package:Atena/connections/credentialConnection.dart';
import 'package:provider/provider.dart';
import 'package:Atena/views/userViews/configView/themeNotifier.dart';

class SchoolLoginView extends StatefulWidget {
  @override
  State<SchoolLoginView> createState() => _SchoolLoginViewState();
}

class _SchoolLoginViewState extends State<SchoolLoginView> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login() async {
    String signupStatus =
        await schoolLoginCredentialConnection(name.text, password.text);

    if (signupStatus == "Escola fez login com sucesso") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserPageView()),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Text(signupStatus),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      backgroundColor: theme.themeData.scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            color: theme.themeData.cardColor,
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
                    style: TextStyle(color: theme.themeData.colorScheme.primary),
                    decoration: InputDecoration(
                      labelText: "Nome",
                      labelStyle:
                          TextStyle(color: theme.themeData.colorScheme.secondary),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: theme.themeData.colorScheme.secondary),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: theme.themeData.colorScheme.primary,
                            width: 2),
                      ),
                    ),
                  ),

                  TextField(
                    controller: password,
                    obscureText: true,
                    style: TextStyle(color: theme.themeData.colorScheme.primary),
                    decoration: InputDecoration(
                      labelText: "Senha",
                      labelStyle:
                          TextStyle(color: theme.themeData.colorScheme.secondary),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: theme.themeData.colorScheme.secondary),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: theme.themeData.colorScheme.primary,
                            width: 2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.themeData.colorScheme.secondary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                    child: const Text("Login"),
                  ),

                  const SizedBox(height: 10),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserSignupView()),
                      );
                    },
                    child: Text(
                      "Sou aluno",
                      style: TextStyle(
                        color: theme.themeData.colorScheme.secondary,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SchoolSignupView()),
                      );
                    },
                    child: Text(
                      "Não tenho conta",
                      style: TextStyle(
                        color: theme.themeData.colorScheme.secondary,
                      ),
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
