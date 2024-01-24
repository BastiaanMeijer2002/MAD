import 'dart:convert';
import 'dart:io';

import 'package:clucknrides/repositories/rentalRepository.dart';

import '../models/Rental.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<void> updateRentalStatus(FlutterSecureStorage storage, RentalRepository rentals, Rental rental, String status) async {
  final jwt = await storage.read(key: "jwt");
  final response = await http.patch(
    Uri.parse('${dotenv.env["API_BASE_URL"]}/api/rentals/${rental.id}'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
      HttpHeaders.contentTypeHeader: 'application/json'
    },
    body: jsonEncode({
      'id': rental.id,
      'state': status,
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