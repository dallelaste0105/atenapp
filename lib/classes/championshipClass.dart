import 'package:Atena/connections/championshipConnection.dart';

class ChampionshipClass {
  List yourChampionships = [];
  bool firstExecution = true;
  
  Future<String> createChampionship(name, code) async {
    return await createChampionshipConnection(name, code);
  }

  Future<List> takeAndSaveChampionships() async {
    if (firstExecution) {
      final yChamps = await getChampionshipsConnection();
      yourChampionships = yChamps;
      firstExecution = false;
      print(yourChampionships);
      return yourChampionships;
    }
    return yourChampionships;
  }

  void reloadState(){
    firstExecution = true;
  }

}