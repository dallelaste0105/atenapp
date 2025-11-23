import 'package:Atena/classes/classClass.dart';
import 'package:flutter/material.dart';

ClassClass classClassInstance = ClassClass();

class StudentClassesViewScreen extends StatefulWidget {
  @override
  State<StudentClassesViewScreen> createState() => _StudentClassesViewScreenState();
}

class _StudentClassesViewScreenState extends State<StudentClassesViewScreen> {

  TextEditingController className = TextEditingController();
  TextEditingController classCode = TextEditingController();

  Future<void> enterClassState() async {
    String state = await classClassInstance.enterClass(className, classCode);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Text(state as String),
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Column(children: [
      Container(padding: EdgeInsets.only(top: 70, right: 40, left: 40, bottom: 40), color: Colors.blue , child: Column(children: [
        TextField(controller: className, decoration: InputDecoration(hintText: "Nome")),
        TextField(controller: classCode, decoration: InputDecoration(hintText: "Código")),
        Padding(padding: EdgeInsetsGeometry.all(10)),
        ElevatedButton(onPressed: (){enterClassState();}, child: Text("Entrar"))
      ]),)
    ])));
  }
}