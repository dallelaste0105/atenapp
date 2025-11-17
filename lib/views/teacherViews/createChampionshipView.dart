import 'package:flutter/material.dart';

class CreateChampionshipView extends StatefulWidget {
  @override
  State<CreateChampionshipView> createState() => _CreateChampionshipViewState();
}

class _CreateChampionshipViewState extends State<CreateChampionshipView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      //adicionar um nome ao campeonato
      //selecionar a turma do campeonato (no controller verificar se é professor ou escola, as buscas vão ser diferentes entre eles [um prof seleciona as turmas que está, a escola as q ela tem])
      //selecionar a matéria e/ou tópico e/ou subtopico
      //depois vai ter uma tela para o professor adicionar eventos a esse campeonato, o aluno clica no camp, se tiver eventos nele, o aluno participa
    ]));
  }
}