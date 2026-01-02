import 'connectionFunctions.dart';

signupConnection(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("post", "credential/signup", body);
}

loginConnection(Map<String, dynamic> body) async {
  final response = await simpleFeedBackConnection("post", "credential/login", body);
  if (response["ok"] == true && response["jwt"] != null) {
    await saveJWT(response["jwt"].toString()); 
  }
  return response; 
}