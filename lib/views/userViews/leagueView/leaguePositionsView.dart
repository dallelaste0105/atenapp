import 'package:flutter/material.dart';
import 'package:Atena/classes/leagueClass.dart';
import 'package:Atena/views/userViews/leagueView/filterQuestionsView.dart';
import 'package:Atena/views/widgets/competitorWidget.dart';

final LeagueClassInstance = LeagueClass();
bool _firstExecution = false;

class LeagueScreen extends StatefulWidget {
  @override
  _LeagueScreenState createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCompetitors();
  }

  Future<void> _loadCompetitors() async {
    await LeagueClassInstance.getCompetitorsLeague();
    setState(() {
      _loading = false;
      _firstExecution = true;
    });
  }

  Future<void> _reloadPage() async {
    setState(() {
      _loading = true;
      _firstExecution = false;
    });
    await _loadCompetitors();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liga'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadPage, // botão de recarregar
          ),
        ],
      ),
      body: FutureBuilder(
        future: LeagueClassInstance.showCompetitorsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar participantes"));
          }

          if (snapshot.hasData) {
            final data = snapshot.data as List;
            if (data.isEmpty) {
              return const Center(child: Text("Nenhum participante encontrado"));
            }

            // 🔽 Ordena por pontos (maior → menor)
            data.sort((a, b) => (b['points'] ?? 0).compareTo(a['points'] ?? 0));

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final competitor = data[index];
                return Competitor(
                  name: competitor['name'] ?? 'Sem nome',
                  points: competitor['points'] ?? 0,
                );
              },
            );
          } else {
            return const Center(child: Text("Erro inesperado"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen()));
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
