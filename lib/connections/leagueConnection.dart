import 'package:Atena/connections/connectionsConfig.dart';

Future<dynamic> getCompetitorsLeagueConnection() async {
  return await defaultConnection(
    "/league/getcompetitorsleague",
    "POST",
    body: {},
  );
}