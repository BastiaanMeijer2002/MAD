import 'dart:convert';
import 'dart:io';

import 'package:clucknrides/models/Inspection.dart';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/Car.dart';
import '../models/Customer.dart';
import '../models/Rental.dart';
import 'fetch_customer.dart';

Future<void> stopRent(FlutterSecureStorage storage, Car car, CustomerRepository customers, RentalRepository rentals, InspectionRepository inspections, String file, String desc,) async {
  Rental rental = await rentals.activeRental(car);

  final jwt = await storage.read(key: "jwt");
  await createInspection(storage, file, desc, rental, inspections);

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

Future<Inspection?> createInspection(FlutterSecureStorage storage, String file, String desc, Rental rental, InspectionRepository inspections) async{
  final jwt = await storage.read(key: "jwt");

  if (file.isNotEmpty && desc.isNotEmpty) {
    final inspectionResponse = await http.post(
        Uri.parse('${dotenv.env["API_BASE_URL"]}/api/inspections'),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
          HttpHeaders.contentTypeHeader: 'application/json'
        },
        body: jsonEncode({
          'result': desc,
          'photo': file,
          'rental': rental.toJson(),
        })
    );

    if (inspectionResponse.statusCode == 201) {
      Map<String, dynamic> responseData = jsonDecode(inspectionResponse.body);
      print('test ${responseData.toString()}');
      final inspection =  Inspection.fromJson(responseData);
      print(inspection.toJson().toString());
      await inspections.insertInspection(inspection);
      return inspection;
    }

    throw const HttpException("Creating inspection failed");

  }

  return null;
}