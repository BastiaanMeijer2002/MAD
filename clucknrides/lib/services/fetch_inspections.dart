import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clucknrides/models/Inspection.dart';
import 'package:clucknrides/models/Rental.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/Car.dart';
import 'package:http/http.dart' as http;

import '../repositories/customerRepository.dart';


Future<List<Inspection>> fetchInspections(FlutterSecureStorage storage, InspectionRepository inspections) async {
  final jwt = await storage.read(key: "jwt");
  final response = await http.get(
    Uri.parse('${dotenv.env["API_BASE_URL"]}/api/inspections'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    final List<Inspection> inspectionList = jsonList.map((json) => Inspection.fromJson(json)).toList();
    await inspections.insertInspections(inspectionList);
    return inspectionList;
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }

}