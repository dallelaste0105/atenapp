import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF0D47A1);
  static const Color secondary = Color(0xFF1976D2);
  static const Color tertiary = Color(0xFF42A5F5);
  static const Color quaternary = Color(0xFF90CAF9);
  static const Color quinternary = Color(0xFFE3F2FD);

  // Tema claro
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: quinternary,
  );

  // Tema escuro
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF16305D),
      secondary: Color(0xFF3C5291),
      tertiary: Color(0xFF546E7A),
      surface: Color(0xFF090C0F),
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF090C0F),
  );
}

