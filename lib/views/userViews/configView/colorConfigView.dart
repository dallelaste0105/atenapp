import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = const Color(0xFF0D47A1);
Color secondaryColor = const Color(0xFF1565C0);
Color tertiaryColor = const Color(0xFF1976D2);
Color quaternaryColor = const Color(0xFFBBDEFB);
Color quinternaryColor = const Color(0xFFE3F2FD);

Color darkPrimaryColor = const Color.fromARGB(255, 223, 224, 226);
Color darkSecondaryColor = const Color.fromARGB(255, 22, 48, 93);
Color darkTertiaryColor = const Color.fromARGB(255, 60, 82, 145);
Color darkQuaternaryColor = const Color.fromARGB(255, 9, 12, 44);
Color darkQuinternaryColor = const Color.fromARGB(255, 9, 12, 15);

Color lightPrimaryColor = const Color(0xFF0D47A1);
Color lightSecondaryColor = const Color(0xFF1976D2);
Color lightTertiaryColor = const Color(0xFF42A5F5);
Color lightQuaternaryColor = const Color(0xFFBBDEFB);
Color lightQuinternaryColor = const Color(0xFFE3F2FD);

class ColorConfig {
  Future<void> saveColorConfig(String color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("colorConfig", color);
  }

  Future<void> getColorConfig() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedColorConfig = prefs.getString("colorConfig");

    if (selectedColorConfig == "dark") {
      primaryColor = darkPrimaryColor;
      secondaryColor = darkSecondaryColor;
      tertiaryColor = darkTertiaryColor;
      quaternaryColor = darkQuaternaryColor;
      quinternaryColor = darkQuinternaryColor;
    } else {
      primaryColor = lightPrimaryColor;
      secondaryColor = lightSecondaryColor;
      tertiaryColor = lightTertiaryColor;
      quaternaryColor = lightQuaternaryColor;
      quinternaryColor = lightQuinternaryColor;
    }
  }
}
