import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigClass extends ChangeNotifier {
  bool _isDark = false;
  bool get isDark => _isDark;

  final Color _lightPrimary = const Color.fromARGB(255, 39, 60, 117);
  final Color _lightSecondary = const Color.fromARGB(255, 208, 208, 211);
  final Color _lightBackground = const Color.fromARGB(255, 240, 240, 245);

  final Color _darkPrimary = const Color.fromARGB(255, 60, 90, 180);
  final Color _darkSecondary = const Color.fromARGB(255, 14, 32, 54);
  final Color _darkBackground = const Color.fromARGB(255, 10, 20, 35);

  Color get primaryColor => _isDark ? _darkPrimary : _lightPrimary;
  Color get secundaryColor => _isDark ? _darkSecondary : _lightSecondary;

  ConfigClass() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool("isDark") ?? false;
    notifyListeners();
  }

  Future<void> changeTheme() async {
    _isDark = !_isDark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", _isDark);
    notifyListeners();
  }

  ThemeData getThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _isDark ? _darkPrimary : _lightPrimary,
        secondary: _isDark ? _darkSecondary : _lightSecondary,
        brightness: _isDark ? Brightness.dark : Brightness.light,
        surface: _isDark ? _darkSecondary : _lightBackground,
      ),
      scaffoldBackgroundColor: _isDark ? _darkBackground : _lightSecondary,
      appBarTheme: AppBarTheme(
        backgroundColor: _isDark ? _darkSecondary : _lightPrimary,
        foregroundColor: Colors.white,
      ),
    );
  }
}