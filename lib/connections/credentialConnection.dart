import 'package:Atena/connections/connectionsConfig.dart'; 

Future<dynamic> signupCredentialConnection(
  name,
  email,
  password,
  schoolName,
  yourCode,
) async {
  return await defaultConnection(
    "/credential/signup",
    "POST",
    body: {
      "name": name,
      "email": email,
      "password": password,
      "schoolName": schoolName,
      "yourCode": yourCode,
    },
  );
}

Future<dynamic> loginCredentialConnection(name, password, userType) async {
  final response = await defaultConnection(
    "/credential/login",
    "POST",
    body: {
      "name": name,
      "password": password,
      "userType": userType,
    },
  );

  // Verifica se a resposta é um Map e tem o token (graças ao ajuste no config)
  if (response is Map && response['token'] != null) {
    await saveTokenCredentialConnection(response['token']);
    // Retorna a mensagem se houver, senão retorna o próprio objeto
    return response['message'] ?? response; 
  }

  return response;
}

Future<dynamic> schoolSignupCredentialConnection(
  name,
  email,
  password,
  schoolCode,
  teacherCode,
  studentCode,
) async {
  return await defaultConnection(
    "/credential/schoolsignup",
    "POST",
    body: {
      "name": name,
      "email": email,
      "password": password,
      "schoolCode": schoolCode,
      "teacherCode": teacherCode,
      "studentCode": studentCode,
    },
  );
}

Future<dynamic> schoolLoginCredentialConnection(name, password) async {
  final response = await defaultConnection(
    "/credential/schoollogin",
    "POST",
    body: {
      "name": name,
      "password": password
    },
  );

  if (response is Map && response['token'] != null) {
    await saveTokenCredentialConnection(response['token']);
    return response['message'] ?? response;
  }

  return response;
}