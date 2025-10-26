// main.dart
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:muto_system/views/test/notificationViewTest/notificationViewTest.dart';
import 'package:muto_system/views/userViews/homeView/homeView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  // Definição dos temas
  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade800,
        brightness: Brightness.light,
        // Cores personalizadas para o modo CLARO
        primary: Colors.blue.shade800,
        background: Colors.grey.shade50, // Fundo principal CLARO
        surface: Colors.white, // Fundo dos cards/superfícies CLARO
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade800,
        brightness: Brightness.dark,
        // Cores personalizadas para o modo ESCURO
        primary: const Color(0xFF5E81AC), // Destaque (cor de _corDestaque)
        background: const Color(
          0xFF191D26,
        ), // Fundo principal ESCURO (_corFundoPrincipal)
        surface: const Color(
          0xFF22283A,
        ), // Fundo dos cards/superfícies ESCURO (_corCardPrincipal)
        onSurface: Colors.white, // Texto primário
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: _buildLightTheme(),
      dark: _buildDarkTheme(),
      initial:
          savedThemeMode ??
          AdaptiveThemeMode.system, // Usa o tema do sistema por padrão
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Muto System',
        theme: theme,
        darkTheme: darkTheme,
        // home: HomeView(token: ''),
        home: NotificationTest(),
      ),
    );
  }
}
