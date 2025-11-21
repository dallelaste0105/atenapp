import 'package:Atena/connections/connectionsConfig.dart';

Future<dynamic> createClass(name, teacherCode, studentCode) async {
  return await defaultConnection(
    "/class/createclass",
    "POST",
    body: {
      "name": name,
      "teacherCode": teacherCode,
      "studentCode": studentCode
    },
  );
}

Future<dynamic> enterClass(name, code) async {
  return await defaultConnection(
    "/class/enterclass",
    "POST",
    body: {
      "name": name,
      "code": code
    },
  );
}

Future<dynamic> getSchoolClass() async {
  return await defaultConnection(
    "/class/enterclass",
    "GET",
    body: {},
  );
}