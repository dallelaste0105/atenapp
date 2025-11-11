// main.dart
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:muto_system/views/generalViews/signupView.dart';
import 'package:muto_system/views/userViews/homeView/homeView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:muto_system/views/userViews/leagueView/leaguePositionsView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  final prefs = await SharedPreferences.getInstance();
  final String? savedToken = prefs.getString('token');

  runApp(MyApp(savedThemeMode: savedThemeMode, savedToken: savedToken));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final String? savedToken;

  const MyApp({super.key, this.savedThemeMode, this.savedToken});

  // Tema claro
  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade800,
        brightness: Brightness.light,
        primary: Colors.blue.shade800,
        background: Colors.grey.shade50,
        surface: Colors.white,
      ),
    );
  }

  // Tema escuro
  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade800,
        brightness: Brightness.dark,
        primary: const Color(0xFF5E81AC),
        background: const Color(0xFF191D26),
        surface: const Color(0xFF22283A),
        onSurface: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: _buildLightTheme(),
      dark: _buildDarkTheme(),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Muto System',
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: CredentialView(),
      ),
    );
  }
}
