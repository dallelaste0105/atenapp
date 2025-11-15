import 'package:Atena/views/userViews/configView/appColors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData = AppColors.lightTheme;
  double _fontSize = 16;

  ThemeNotifier() {
    loadPreferences();
  }

  ThemeData get themeData => _themeData;
  double get fontSize => _fontSize;

  // ----------- CARREGAR CONFIGURAÇÕES -----------
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final savedTheme = prefs.getString("themeMode");
    final savedFontSize = prefs.getString("fontSizeConfig");

    // Tema
    if (savedTheme == "dark") {
      _themeData = AppColors.darkTheme;
    } else {
      _themeData = AppColors.lightTheme;
    }

    // Fonte
    if (savedFontSize == "small") {
      _fontSize = 14;
    } else if (savedFontSize == "large") {
      _fontSize = 20;
    } else {
      _fontSize = 16;
    }

    notifyListeners();
  }

  // ----------- TROCAR TEMA -----------
  Future<void> setTheme(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("themeMode", mode);

    if (mode == "dark") {
      _themeData = AppColors.darkTheme;
    } else {
      _themeData = AppColors.lightTheme;
    }

    notifyListeners();
  }

  // ----------- TROCAR TAMANHO DA FONTE -----------
  Future<void> setFontSize(String size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("fontSizeConfig", size);

    if (size == "small") {
      _fontSize = 14;
    } else if (size == "large") {
      _fontSize = 20;
    } else {
      _fontSize = 16;
    }

    notifyListeners();
  }
}
