import 'package:Atena/connections/championshipConnection.dart';

class ChampionshipClass {
  List yourChampionships = [];
  bool tascfirstExecution = true;
  bool tascefirstExecution = true;
  
  Future<String> createChampionship(name, code) async {
    return await createChampionshipConnection(name, code);
  }

  Future<List> takeAndSaveChampionships() async {
    if (tascfirstExecution) {
      final yChamps = await getChampionshipsConnection();
      yourChampionships = yChamps;
      tascfirstExecution = false;
      return yourChampionships;
    }
    return yourChampionships;
  }

  Future<List> takeAndSaveChampionshipEvent() async {
    if (tascefirstExecution) {
      final yChamps = await getChampionshipsConnection();
      yourChampionships = yChamps;
      tascefirstExecution = false;
      return yourChampionships;
    }
    return yourChampionships;
  }

  void tascereloadState(){
    tascefirstExecution = true;
  }

  void tascreloadState(){
    tascfirstExecution = true;
  }

}