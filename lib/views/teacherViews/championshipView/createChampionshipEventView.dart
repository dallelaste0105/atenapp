import 'package:Atena/classes/championshipClass.dart';
import 'package:flutter/material.dart';

ChampionshipClass championshipClassInstance = ChampionshipClass();

class CreateChampionshipEventViewScreen extends StatefulWidget {
  
  final int championshipId;

  const CreateChampionshipEventViewScreen({
    super.key,
    required this.championshipId
  });
  
  @override
  State<CreateChampionshipEventViewScreen> createState() => _CreateChampionshipEventViewScreenState();
}

class _CreateChampionshipEventViewScreenState extends State<CreateChampionshipEventViewScreen> {
  @override
  //deve aparecer a rodada do momento e a opção de incerrar ela
  //nela tb ficam as estatísticas
  //o professor pd ver as stats gerais clicando em um btn nessa tela
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rodada")),
      body: Center(child: Column(children: [
        Card(child: Column(children: [
          Text("Adicionar rodada"),
          Row(children: [
            ElevatedButton(onPressed: (){}, child: Text("Questões próprias")),
            ElevatedButton(onPressed: (){}, child: Text("Questões do banco")),
          ]),
          Row(children: [
            ElevatedButton(onPressed: (){}, child: Text("Questões filtradas")),
            ElevatedButton(onPressed: (){}, child: Text("Lições"))
          ])
        ])),
        FutureBuilder(future: championshipClassInstance.takeAndSaveChampionshipEvent(), builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {}

          if (snapshot.hasData) {}

          return Text("Nenhuma rodada encontrada");

        })
      ])));
  }
}