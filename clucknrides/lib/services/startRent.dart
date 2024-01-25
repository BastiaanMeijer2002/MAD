import 'dart:convert';
import 'dart:io';

import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:clucknrides/services/authenticationService.dart';
import 'package:clucknrides/services/fetch_customer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/Car.dart';
import '../models/Customer.dart';
import '../models/Rental.dart';

Future<void> startRent(FlutterSecureStorage storage, Car car, CustomerRepository customers, RentalRepository rentals) async {
  Customer customer = await currentCustomer(storage);

  final jwt = await storage.read(key: "jwt");
  final response = await http.post(
    Uri.parse('${dotenv.env["API_BASE_URL"]}/api/rentals'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
      HttpHeaders.contentTypeHeader: 'application/json'
    },
    body: jsonEncode({
      'fromDate': DateTime.now().toLocal().toString().split(' ')[0],
      'state': 'ACTIVE',
      'customer': customer.toJson(),
      'car': car.toJson(),
    }),
  );

  if (response.statusCode == 201) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    Rental rental = Rental.fromJson(responseData);
    await rentals.insertRental(rental);
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }
}