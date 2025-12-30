import 'package:flutter/material.dart';
import 'package:teste/views/pages/allPages/config.dart';
import 'package:teste/views/pages/userPages/lesson.dart';
import 'package:teste/views/pages/userPages/profile.dart';

class UserPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 0),
      scrollDirection: Axis.horizontal,
      children: [
        Profile(),
        Lesson(),
        Config()
      ],
    );
}

class StudentPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 0),
      scrollDirection: Axis.horizontal,
      children: [
        
      ],
    );
}

class TeacherPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 0),
      scrollDirection: Axis.horizontal,
      children: [
        
      ],
    );
}

class SchoolPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 0),
      scrollDirection: Axis.horizontal,
      children: [
        
      ],
    );
}