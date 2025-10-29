import 'package:flutter/material.dart';
import 'package:muto_system/views/userViews/leagueView/questionView.dart';

class TelaPadrao extends StatefulWidget {
  @override
  _TelaPadraoState createState() => _TelaPadraoState();
}

class _TelaPadraoState extends State<TelaPadrao> {
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
              difficulty: 2,
              searchType:"all",
              howMany:3
            ),
          ),
        );


      }, child: Text("Fazer questões"))),
    );
  }
}