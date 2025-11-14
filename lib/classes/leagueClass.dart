import 'package:Atena/connections/leagueConnection.dart';

class LeagueClass {
  List<dynamic> competitorsList = [];

  Future<void> getCompetitorsLeague() async {
    // busca dados e armazena na lista
    competitorsList = await getCompetitorsLeagueConnection();
  }

  Future<List<dynamic>> showCompetitorsList() async {
    // retorna a lista atual
    return competitorsList;
  }
}

final LeagueClassInstance = LeagueClass();
