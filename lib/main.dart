import 'package:flutter/material.dart';
import 'package:muto_system/views/generalViews/signupView.dart';
import 'package:muto_system/views/studentViews/subjectsViews/subjectView.dart';

void main() => runApp(myApp());

// ignore: camel_case_types
class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SubjectProgressPage());
  }
}
