import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<bool> authenticateUser(String username, String password, FlutterSecureStorage storage) async {
  final response = await http.post(
    Uri.parse("http://localhost:8080/api/authenticate"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "username": username,
      "password": password,
      "rememberMe": false
    })
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final String token = jsonData['id_token'];
    await storage.write(key: "jwt", value: token);
    return true;
  } else if (response.statusCode == 401) {
    return false;
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }
}