import 'dart:convert';
import 'dart:io';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/services/fetch_customer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/Customer.dart';

Future<bool> authenticateUser(String username, String password, FlutterSecureStorage storage, CustomerRepository customerRepository) async {
  final response = await http.post(
    Uri.parse("${dotenv.env["API_BASE_URL"]}/api/authenticate"),
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

    Customer customer = await fetchCustomer(storage, customerRepository);
    await customerRepository.insertCustomer(customer);
    await storage.write(key: "customer", value: customer.serialize());

    return true;
  } else if (response.statusCode == 401) {
    return false;
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }
}

Future<bool> registerUser({
  required String username,
  required String firstName,
  required String lastName,
  required String email,
  required String password,
}) async {
  final response = await http.post(
    Uri.parse("${dotenv.env["API_BASE_URL"]}/api/AM/register"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "login": username,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "activated": true,
      "langKey": "en",
      "authorities": ["ROLE_USER"],
      "password": password,
    }),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }
}