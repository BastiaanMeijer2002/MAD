import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clucknrides/models/Rental.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/Car.dart';
import 'package:http/http.dart' as http;


Future<List<Rental>> fetchRentals(FlutterSecureStorage storage) async {
  final jwt = await storage.read(key: "jwt");
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/rentals'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $jwt',
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    log(response.body);
    final List<Rental> carList = jsonList.map((json) => Rental.fromJson(json)).toList();
    return carList;
  } else {
    throw HttpException('${response.statusCode}: ${response.body}');
  }

}