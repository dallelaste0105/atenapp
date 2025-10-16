import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> signup(name, email, password, school_name, your_code) async {
  try {
    final url = Uri.parse("http://localhost:3000/credential/signup");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
        "school_name": school_name,
        "your_code": your_code,
      }),
    );
    if (res.statusCode == 200) {
      return 200;
    }
    return 500;
    
}
  catch(error){
    return 500;
  }
}