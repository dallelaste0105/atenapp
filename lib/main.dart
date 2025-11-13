import 'package:flutter/material.dart';
import 'package:muto_system/views/generalViews/userSignupView.dart';
import 'package:muto_system/views/generalViews/colorConfigView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final colorConfig = ColorConfig();
  await colorConfig.saveColorConfig("dark");
  await colorConfig.getColorConfig();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserSignupView(),
    );
  }
}
