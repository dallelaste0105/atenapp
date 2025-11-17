import 'package:Atena/views/userViews/configView/themeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/generalViews/userSignupView.dart';
import 'views/pageViews.dart';
import 'connections/basicDataConnection.dart';
import 'connections/credentialConnection.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: themeNotifier.themeData,
      home: const AuthCheckScreen(),
      routes: {
        '/login': (context) => UserSignupView(),
      },
    );
  }
}

class AuthCheckScreen extends StatefulWidget {
  const AuthCheckScreen({super.key});

  @override
  State<AuthCheckScreen> createState() => _AuthCheckScreenState();
}

class _AuthCheckScreenState extends State<AuthCheckScreen> {
  late Future<String> _loadUserFuture;

  @override
  void initState() {
    super.initState();
    _loadUserFuture = _loadUserType();
  }

  Future<String> _loadUserType() async {
    try {
      final userBasicData = await getUserBasicDataConnection();
      if (userBasicData.isNotEmpty &&
          userBasicData.containsKey("userType") &&
          userBasicData["userType"] != null) {
        return userBasicData["userType"].toString();
      }
      await deleteToken();
      return "";
    } catch (e) {
      await deleteToken();
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadUserFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: Image.asset(
                    'assets/images/logoWithoutBackground.png',
                    height: 120,
                  )
            ),
          );
        }

        switch (snapshot.data) {
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
    );
  }
}
