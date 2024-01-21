import 'dart:convert';
import 'dart:io';
import 'package:clucknrides/models/Customer.dart';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<Customer> fetchCustomer(FlutterSecureStorage storage, CustomerRepository customers) async {
  final jwt = await storage.read(key: "jwt");
  final response = await http.get(
    Uri.parse('${dotenv.env["API_BASE_URL"]}/api/AM/me'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Customer.fromJson(jsonResponse);
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }
}