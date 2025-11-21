import 'package:Atena/connections/championshipConnection.dart';

class ChampionshipClass {
  List<Map<String, dynamic>> yourChampionships = [];
  bool _isLoaded = false;

  Future<void> takeAndSaveYourChampionships({bool forceReload = false}) async {
    if (_isLoaded && !forceReload) { 
      return;
    }

    yourChampionships = await getChampionships();
    _isLoaded = true;
  }
  
  Future<List<Map<String, dynamic>>> showYourChampionships() async {
    return yourChampionships;
  }

  Future<String> createChampionship(name, participantcode, admcode) async {
    final response = await createChampionship(name, participantcode, admcode);
    return response;
  }
}


//createChampionship(name, participantcode, admcode)
