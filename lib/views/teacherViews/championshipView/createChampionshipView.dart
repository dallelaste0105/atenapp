import 'package:Atena/classes/championshipClass.dart';
import 'package:flutter/material.dart';

ChampionshipClass championshipClassInstance = ChampionshipClass();

class CreateChampionshipViewScreen extends StatefulWidget {
  @override
  State<CreateChampionshipViewScreen> createState() => _CreateChampionshipViewScreenState();
}

class _CreateChampionshipViewScreenState extends State<CreateChampionshipViewScreen> {
  
  TextEditingController name = TextEditingController();
  TextEditingController code = TextEditingController();

  Future<void> createChampionshipState() async {
    String state = await championshipClassInstance.createChampionship(name.text, code.text);
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Text(state),
          );
        },
      );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(children: [
      Container(padding: EdgeInsets.only(top: 70, right: 40, left: 40, bottom: 40), color: Colors.blue , child: Column(children: [
        TextField(controller: name, decoration: InputDecoration(hintText: "Nome")),
        TextField(controller: code, decoration: InputDecoration(hintText: "Código")),
        Padding(padding: EdgeInsetsGeometry.all(10)),
        ElevatedButton(onPressed: (){createChampionshipState();}, child: Text("Criar"))
      ]),)
    ])));
  }
}