import 'package:flutter/material.dart';
import 'package:muto_system/views/userViews/leagueView/leaguePositionsView.dart';

class UserPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 1),
      scrollDirection: Axis.horizontal,
      children: [
        LeagueScreen()
      ],
    );
}

class StudentPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 1),
      scrollDirection: Axis.horizontal,
      children: [
        LeagueScreen()
      ],
    );
}

class TeacherPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 1),
      scrollDirection: Axis.horizontal,
      children: [
        LeagueScreen()
      ],
    );
}

class SchoolPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) => PageView(
      controller: PageController(initialPage: 1),
      scrollDirection: Axis.horizontal,
      children: [
        LeagueScreen()
      ],
    );
}