import 'package:flutter/material.dart';
import 'package:muto_system/classes/leagueClass.dart';
import 'package:muto_system/views/widgets/competitorWidget.dart';

class LeagueScreen extends StatefulWidget {
  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  late Future<List<dynamic>> _competitorsFuture;

  @override
  void initState() {
    super.initState();
    // busca sempre direto da API
    _competitorsFuture = LeagueClassInstance.getCompetitorsLeague();
  }

  Future<void> _refresh() async {
    setState(() {
      _competitorsFuture = LeagueClassInstance.getCompetitorsLeague();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Competidores')),
      body: FutureBuilder<List<dynamic>>(
        future: _competitorsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final data = snapshot.data;

          if (data == null || data.isEmpty) {
            return const Center(child: Text('Nenhum competidor encontrado.'));
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final competitor = data[index];
                return Competitor(
                  name: competitor['name'] ?? 'Sem nome',
                  points: competitor['points'] ?? 0,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
