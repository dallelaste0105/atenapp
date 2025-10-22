import 'package:flutter/material.dart';
import 'package:muto_system/views/userViews/credentialViews/signupView.dart';
import 'package:muto_system/views/userViews/homeView/homeView.dart';

void main() => runApp(myApp());

// ignore: camel_case_types
class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeView(token: '',));
  }
}
