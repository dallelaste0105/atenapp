import 'package:Atena/connections/championshipConnection.dart';

class ChampionshipClass {
  List yourChampionships = [];
  bool tascfirstExecution = true;
  bool tascefirstExecution = true;
  bool contentfirstExecution = true;
  List<Map<String, dynamic>> notConfirmedFilteredQuestions = [];
  
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

  Future<List> getContents(contentType, contentValue) async {

  if (contentType == "subject") {
    final subjects = await getSubjectsForChampionshipBlockConnection();
    return subjects.map((e) => e["subject"].toString()).toList();
  }

  else if (contentType == "topic") {
    final topics = await getTopicsForChampionshipBlockConnection(contentValue);
    return topics.map((e) => e["topic"].toString()).toList();
  }

  else {
    final subtopics = await getSubtopicsForChampionshipBlockConnection(contentValue);
    return subtopics.map((e) => e["subtopic"].toString()).toList();
  }
}

void addNotConfirmedFilteredQuestions(subtopic, difficulty, howmany){
  notConfirmedFilteredQuestions.add({"subtopic":subtopic, "difficulty":difficulty, "howmany":howmany});
  print(notConfirmedFilteredQuestions);
}

}

/*
event: id, name, finishdate, championshipid

eventitem: id, eventid, itemtype, itemid <---- excluir

filteredquestioneventitem: id, subtopic, difficulty, howmany
*/