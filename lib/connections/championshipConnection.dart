import 'package:Atena/connections/connectionsConfig.dart';

Future<dynamic> createChampionshipConnection(name, code) async {
  return await defaultConnection(
    "/championship/createchampionship",
    "POST",
    body: {
      "name": name,
      "code": code
    },
  );
}

Future<dynamic> searchChampionship(name) async {
  return await defaultConnection(
    "/championship/searchchampionship",
    "POST",
    body: {
      "name": name
    },
  );
}

Future<dynamic> enterChampionship(name, code, hierarchyType) async {
  return await defaultConnection(
    "/championship/enterchampionship",
    "POST",
    body: {
      "name": name,
      "code": code,
      "hierarchyType" : hierarchyType
    },
  );
}

Future<dynamic> creatEvent(championshipid, name, finishdate, type) async {
  return await defaultConnection(
    "/championship/createvent",
    "POST",
    body: {
      "championshipid": championshipid,
      "name": name,
      "finishdate": finishdate,
      "type": type
    },
  );
}

Future<dynamic> excludeChampionship(championshipName) async {
  return await defaultConnection(
    "/championship/excludechampionship",
    "POST",
    body: {
      "championshipName": championshipName
    },
  );
}

Future<dynamic> getChampionships() async {
  return await defaultConnection(
    "/championship/getchampionships",
    "GET",
  );
}