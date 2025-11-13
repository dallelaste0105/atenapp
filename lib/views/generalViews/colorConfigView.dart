import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = const Color(0xFF121212); 
Color secondaryColor = const Color(0xFFFFFFFF); 
Color tertiaryColor = const Color(0xFF1E88E5); 
Color quaternaryColor = const Color(0xFF90CAF9); 
Color quinternaryColor = const Color(0xFFBBDEFB); 

Color darkPrimaryColor = const Color(0xFF121212);
Color darkSecondaryColor = const Color(0xFFFFFFFF);
Color darkTertiaryColor = const Color(0xFF1E88E5);
Color darkQuaternaryColor = const Color(0xFF90CAF9);
Color darkQuinternaryColor = const Color(0xFFBBDEFB);

Color lightPrimaryColor = const Color(0xFFFFFFFF);
Color lightSecondaryColor = const Color(0xFF000000);
Color lightTertiaryColor = const Color(0xFF1976D2);
Color lightQuaternaryColor = const Color(0xFF64B5F6);
Color lightQuinternaryColor = const Color(0xFFBBDEFB);

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
