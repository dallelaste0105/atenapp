import 'package:flutter/material.dart';
import 'package:teste/views/pages/allPages/config.dart';
import 'package:teste/views/pages/schoolPages/sendNotifications.dart';
import 'package:teste/views/pages/userPages/lessonPages/lessonSubjects.dart';
import 'package:teste/views/pages/userPages/profilePages/profile.dart';

class UserPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 0),
      scrollDirection: Axis.horizontal,
      children: [
        Profile(),
        LessonSubjects(),
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
        Config()
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
        CreateCodes()
      ],
    );
}