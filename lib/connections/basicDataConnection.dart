import 'package:Atena/connections/connectionsConfig.dart';

Future<dynamic> getUserBasicDataConnection() async {
  return await defaultConnection(
    "/basicdata/userbasicdata",
    "POST",
    body: {},
  );
}

Future<dynamic> generalBasicDataConnection() async {
  return await defaultConnection(
    "/basicdata/generalbasicdata",
    "POST",
    body: {},
  );
}