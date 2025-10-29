import 'package:flutter/material.dart';

class ChampionshipDetailsView extends StatefulWidget {
  final int index;
  const ChampionshipDetailsView({super.key, required this.index});
  @override
  State<ChampionshipDetailsView> createState() =>
      _ChampionshipDetailsViewState();
}

class _ChampionshipDetailsViewState extends State<ChampionshipDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Championship Details')),
      body: Center(child: Text('Campeonato Detalhes para: ${widget.index}')),
    );
  }
}
