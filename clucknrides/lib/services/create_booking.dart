import 'dart:convert';
import 'dart:io';

import 'package:clucknrides/models/Car.dart';
import 'package:clucknrides/models/Customer.dart';
import 'package:clucknrides/models/Rental.dart';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:clucknrides/services/authenticationService.dart';
import 'package:clucknrides/services/fetch_customer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


Future<Rental> createBooking(FlutterSecureStorage storage, Car car, CustomerRepository customers, RentalRepository rentals ,DateTime start, DateTime? end) async {
  final jwt = await storage.read(key: "jwt");

  Customer customer = await currentCustomer(storage);
  final response = await http.post(
    Uri.parse('${dotenv.env["API_BASE_URL"]}/api/rentals'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
      HttpHeaders.contentTypeHeader: 'application/json'
    },
    body: jsonEncode({
    'state': 'RESERVED',
    'fromDate': start.toLocal().toString().split(' ')[0],
    'toDate': end != null ? end.toLocal().toString().split(' ')[0] : start.toLocal().toString().split(' ')[0],
    'car': car.toJson(),
    'customer': customer.toJson(),
    })
  );

  if (response.statusCode == 201) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    Rental rental = Rental.fromJsonWithRelated(json, car: car, customer: customer);
    rentals.insertRental(rental);
    return rental;
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }
}