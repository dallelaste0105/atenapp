import 'package:muto_system/connections/questionConnection.dart';
import 'package:flutter/material.dart'; // Mantido, embora possa ser desnecessário

class QuestionClass {
  List<dynamic> questionsList = [];

  Future<void> takeSaveQuestionDataFunction(
      subject, topic, subTopic, difficulty, searchType, howMany) async {
    
    // 1. 'questionsData' vai receber a resposta completa da API
    //    (depois de corrigir o IP, ele vai receber { "message": [...] })
    final dynamic questionsData = await getQuestionConnection(
        subject, topic, subTopic, difficulty, searchType, howMany);

    // DEPURAR: Verifique o que o Flutter está realmente recebendo
    print("RESPOSTA DA API NO FLUTTER: $questionsData"); 

    // --- INÍCIO DA CORREÇÃO ---
    // 2. Verifique se 'questionsData' é um Map e se ele contém a chave "message"
    if (questionsData is Map<String, dynamic> && 
        questionsData.containsKey("message") &&
        questionsData["message"] is List) 
    {
      // 3. Pegue a *lista* de dentro da chave "message"
      questionsList = questionsData["message"] as List<dynamic>;

    } else if (questionsData is List<dynamic>) {
      // Caso de segurança: se a API um dia retornar só a lista
      questionsList = questionsData;
    } else {
      // Se for null ou qualquer outra coisa
      questionsList = [];
    }
    // --- FIM DA CORREÇÃO ---
  }

  // Síncrono, lê os dados já carregados
  dynamic showFirstQuestion() {
    if (questionsList.isEmpty) {
      return null;
    }
    
    // Agora 'questionsList' é a lista correta: [{id: 1, ...}]
    // Então 'questionsList[0]' é o primeiro Map de questão
    // E 'questionsList[0]["subject"]' vai funcionar.
    return questionsList[0]["subject"];
  }

  // Síncrono
  void excludeFirstQuestion() {
    if (questionsList.isNotEmpty) {
      questionsList.removeAt(0);
    }
  }
}