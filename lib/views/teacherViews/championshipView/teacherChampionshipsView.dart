import 'package:Atena/classes/championshipClass.dart';
import 'package:Atena/views/teacherViews/championshipView/createChampionshipView.dart';
import 'package:Atena/views/widgets/championshipCardWidget.dart';
import 'package:flutter/material.dart';

ChampionshipClass championshipClassInstance = ChampionshipClass();

class TeacherChampionshipsViewScreen extends StatefulWidget {
  @override
  State<TeacherChampionshipsViewScreen> createState() => _TeacherChampionshipsViewScreenState();
}

class _TeacherChampionshipsViewScreenState extends State<TeacherChampionshipsViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [ElevatedButton(onPressed: (){championshipClassInstance.tascreloadState();setState((){});}, child: Icon(Icons.replay_outlined))]),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateChampionshipViewScreen()));}, child: Text("Criar campeonato")),
            Expanded(
              child: FutureBuilder(
                future: championshipClassInstance.takeAndSaveChampionships(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: championshipClassInstance.yourChampionships.length,
                      itemBuilder: (context, index) {
                        return TeacherChampionshipCardWidget(
                          name: championshipClassInstance.yourChampionships[index]["name"],
                          id: championshipClassInstance.yourChampionships[index]["id"],
                        );
                      },
                    );
                  }

                  return Center(child: Text("Erro ao buscar campeonatos"));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
