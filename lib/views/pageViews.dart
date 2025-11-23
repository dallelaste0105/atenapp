import 'package:Atena/views/schoolViews/createClassView/createClassView.dart';
import 'package:Atena/views/schoolViews/profileView/schoolProfileView.dart';
import 'package:Atena/views/studentViews/classesView/studentClassesAndFriendsView.dart';
import 'package:Atena/views/studentViews/profileView/studentProfileView.dart';
import 'package:Atena/views/teacherViews/championshipView/createChampionshipView.dart';
import 'package:Atena/views/teacherViews/championshipView/teacherChampionshipsView.dart';
import 'package:Atena/views/teacherViews/profileView/teacherProfileView.dart';
import 'package:Atena/views/userViews/profileView/profileView.dart';
import 'package:flutter/material.dart';
import 'package:Atena/views/userViews/leagueView/leaguePositionsView.dart';


class UserPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 2),
      scrollDirection: Axis.horizontal,
      children: [
        LeagueScreen(),
        LeagueScreen(),
        UserProfileView(),
        LeagueScreen(),
        LeagueScreen()
      ],
    );
}

class StudentPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 0),
      scrollDirection: Axis.horizontal,
      children: [
        StudentProfileView(),
        StudentClassesViewScreen()
      ],
    );
}

class TeacherPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 0),
      scrollDirection: Axis.horizontal,
      children: [
        TeacherProfileView(),
        TeacherChampionshipsViewScreen()
      ],
    );
}

class SchoolPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 0),
      scrollDirection: Axis.horizontal,
      children: [
        SchoolProfileView(),
        CreateClassViewScreen()
      ],
    );
}