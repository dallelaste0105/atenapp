import 'package:muto_system/connections/leagueConnection.dart';

class LeagueClass {
  Future<List<dynamic>> getCompetitorsLeague() async {
    try {
      final response = await getCompetitorsLeagueConnection();

      print('🔹 Resposta bruta da API: $response'); // 👉 mostra exatamente o que veio
      if (response is List) {
        print('✅ É uma lista com ${response.length} itens');
        return response;
      } else {
        print('⚠️ A resposta não é uma lista (tipo: ${response.runtimeType})');
        return [];
      }
    } catch (e) {
      print("❌ Erro ao buscar competidores: $e");
      return [];
    }
  }
}

final LeagueClassInstance = LeagueClass();
