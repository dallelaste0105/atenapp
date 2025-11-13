import 'package:flutter/material.dart';
import 'package:muto_system/connections/basicData.dart';
import 'package:muto_system/views/generalViews/colorConfigView.dart';
import 'package:muto_system/views/generalViews/userSignupView.dart';
import 'package:muto_system/views/userViews/pageViews.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final colorConfig = ColorConfig();
  await colorConfig.saveColorConfig("dark");
  await colorConfig.getColorConfig();

  final userBasicData = await getUserBasicDataConnection();
  String userType = "";

  if (userBasicData.isNotEmpty) {
    userType = userBasicData["userType"] ?? "";
  }

  runApp(MyApp(userType: userType));
}

class MyApp extends StatelessWidget {
  final String userType;

  const MyApp({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    Widget homeWidget;

    switch (userType) {
      case "user":
        homeWidget = UserPageView();
        break;
      case "student":
        homeWidget = StudentPageView();
        break;
      case "teacher":
        homeWidget = TeacherPageView();
        break;
      case "school":
        homeWidget = SchoolPageView();
        break;
      default:
        homeWidget = UserSignupView(); 
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeWidget,
    );
  }
}
