import 'dart:io';

import 'package:clucknrides/models/Inspection.dart';
import 'package:clucknrides/models/Rental.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;


Future<void> removeRental(FlutterSecureStorage storage, RentalRepository rentals,InspectionRepository inspections, Rental rental) async {
  final jwt = await storage.read(key: "jwt");
  Inspection? inspection = await inspections.rentalInspection(rental);

  if (inspection != null) {
    final response = await http.delete(
      Uri.parse('${dotenv.env["API_BASE_URL"]}/api/inspections/${inspection.id}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $jwt',
      },
    );

    if (response.statusCode != 204) {
      throw HttpException('${response.statusCode}: ${response.body}');
    }

  }

  final response = await http.delete(
    Uri.parse('${dotenv.env["API_BASE_URL"]}/api/rentals/${rental.id}'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
    },
  );

  if (response.statusCode != 204) {
    throw HttpException('${response.statusCode}: ${response.body}');
  }
}