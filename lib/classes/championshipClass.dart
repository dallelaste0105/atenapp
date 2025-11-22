import 'package:Atena/connections/championshipConnection.dart';

class ChampionshipClass {
  
  Future<String> createChampionship(name, code) async {
    return await createChampionshipConnection(name, code);
  }

}