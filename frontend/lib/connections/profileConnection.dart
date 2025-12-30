import 'connectionFunctions.dart';

getBasicDataConnection(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("get", "profile/getbasicdata", body);
}