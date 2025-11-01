import 'package:flutter/material.dart';
import 'package:muto_system/views/userViews/leagueView/questionView.dart';

class LeagueScreen extends StatefulWidget {
  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scaffold Padrão')),
      body: Center(child: ElevatedButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionScreen(
              subject: "mat",
              topic: "matbas",
              subTopic: "matbasadi",
              difficulty: 1,
              searchType:"all",
              howMany:1
            ),
          ),
        );


      }, child: Text("Fazer questões"))),
    );
  }
}