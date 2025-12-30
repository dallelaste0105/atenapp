import 'connectionFunctions.dart';

getSubjectsConnection(Map<String, dynamic> body)async{
  return await simpleFeedBackConnection("get", "lesson/getsubjects", body);
}