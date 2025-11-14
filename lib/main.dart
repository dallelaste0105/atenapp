import 'package:flutter/material.dart';
import 'package:Atena/views/generalViews/colorConfigView.dart';
import 'package:Atena/views/userViews/pageViews.dart';
import 'package:Atena/views/generalViews/userSignupView.dart';
import 'package:Atena/connections/basicData.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> loadUserType() async {
    // Carrega tema salvo
    final colorConfig = ColorConfig();
    await colorConfig.getColorConfig();

    // Busca dados básicos do usuário
    final userBasicData = await getUserBasicDataConnection();

    // Se tiver token e userType, retorna o userType
    if (userBasicData.isNotEmpty && userBasicData[3] != null) {
      return userBasicData["userType"];
    }

    // Caso contrário, vai para signup/login
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: loadUserType(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final userType = snapshot.data!;

          switch (userType) {
            case "user":
              return UserPageView();
            case "student":
              return StudentPageView();
            case "teacher":
              return TeacherPageView();
            case "school":
              return SchoolPageView();
            default:
              return UserSignupView();
          }
        },
      ),
    );
  }
}
