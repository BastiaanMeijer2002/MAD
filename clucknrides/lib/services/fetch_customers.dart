import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clucknrides/models/Customer.dart';
import 'package:clucknrides/repositories/carRepository.dart';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/Car.dart';
import 'package:http/http.dart' as http;


Future<List<Customer>> fetchCustomers(FlutterSecureStorage storage, CustomerRepository customers) async {
  final jwt = await storage.read(key: "jwt");
  final response = await http.get(
    Uri.parse('${dotenv.env["API_BASE_URL"]}/api/customers'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    log(response.body);
    final List<Customer> customerList = jsonList.map((json) => Customer.fromJson(json)).toList();
    await customers.insertCustomers(customerList);
    return customerList;
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }

}