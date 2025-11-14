import 'package:Atena/connections/basicData.dart';
import 'package:Atena/connections/leagueConnection.dart';

class BasicDataClass {
  Map data = {};
  Future<void> getUserBasicDataClass() async {
    data = getUserBasicDataConnection() as Map;
  }

  Future<List> showUserBasicDataClass() async {
    return [data[0], data[1]];
  }
}

class OtherBasicDataClass {//implementar a lógica de pegar dados de outro usuário aqui
  Map data = {};
  Future<void> getUserBasicDataClass() async {
    data = getUserBasicDataConnection() as Map;
  }

  Future<List> showUserBasicDataClass() async {
    return [data[0], data[1]];
  }
}