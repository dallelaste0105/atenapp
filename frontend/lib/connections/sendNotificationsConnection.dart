import 'connectionFunctions.dart';

LANCAR_CODIGO_ESTUDANTE(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("post", "credential/lancarcodigoestudante", body);
}

LANCAR_CODIGO_PROFESSOR(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("post", "credential/lancarcodigoprofessor", body);
}

MANDAR_NOTIFICACAO(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("post", "credential/mandarnotificacao", body);
}

verifyUserFCMToken(Map<String, dynamic> body) async {
  return await simpleFeedBackConnection("get", "credential/verifyuserfcmtoken", body);
}

saveUserFCMToken(Map<String, dynamic> body) async {
  return await simpleFeedBackConnection("post", "credential/saveuserfcmtoken", body);
}