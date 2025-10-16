import 'dart:convert';
import 'package:http/http.dart' as http;

Future<int> SignUp(String name, String email, String password, String cod) async {
  try {
    final url = Uri.parse("http://localhost:3000/signup");

    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password, 'cod': cod}),
    );

    return res.statusCode == 200 ? 200 : 500;
  } catch (e) {
    return 500;
  }
}
