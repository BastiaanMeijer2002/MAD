import 'dart:convert';
import 'dart:io';

import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/Car.dart';
import '../models/Customer.dart';
import '../models/Rental.dart';
import 'fetch_customer.dart';

Future<void> stopRent(FlutterSecureStorage storage, Car car, CustomerRepository customers, RentalRepository rentals) async {
  Rental rental = await rentals.activeRental(car);

  final jwt = await storage.read(key: "jwt");
  final response = await http.patch(
    Uri.parse('${dotenv.env["API_BASE_URL"]}/api/rentals/${rental.id}'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
      HttpHeaders.contentTypeHeader: 'application/json'
    },
    body: jsonEncode({
      'id': rental.id,
      'toDate': DateTime.now().toLocal().toString().split(' ')[0],
      'state': 'RETURNED',
      'car': car.toJson(),
    }),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    Rental rental = Rental.fromJson(responseData);
    await rentals.updateRental(rental);
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }
}