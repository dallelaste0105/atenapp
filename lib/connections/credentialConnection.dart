import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> signup(name, email, password, school_name, your_code) async {
  try {
    final url = Uri.parse("http://192.168.1.2:3000/credential/signup");

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

    final responseBody = jsonDecode(res.body);

    switch (responseBody['message']) {
      case '200':
        return 200;
      case '201':
        return 201;
      case '202':
        return 202;
      case '203':
        return 203;
      case '500':
        return 500;
      case '501':
        return 501;
      case '502':
        return 502;
      case '503':
        return 503;
      default:
        return 500;
    }
  } catch (error) {
    return 500;
  }
}
