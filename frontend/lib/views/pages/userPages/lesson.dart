import 'package:flutter/material.dart';
import 'package:teste/connections/lessonConnection.dart';

class Lesson extends StatefulWidget{
  @override
  State<Lesson> createState() => _LessonState();
}

class _LessonState extends State<Lesson> {
  @override
  Widget build(BuildContext context) {
    return(
      FutureBuilder(future: getSubjectsConnection({}), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return (CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return (Scaffold(body: Center(child: Text("Lessons"))));
          }

          return(Image.network("https://static.vecteezy.com/system/resources/thumbnails/024/405/934/small/icon-tech-error-404-icon-isolated-png.png"));
        }
      )
    );
  }
}