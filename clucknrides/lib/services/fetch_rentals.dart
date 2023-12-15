import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clucknrides/models/Rental.dart';
import 'package:dotenv/dotenv.dart';
import '../models/Car.dart';
import 'package:http/http.dart' as http;


Future<List<Rental>> fetchRentals() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/rentals'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImV4cCI6MTcwMjUwNTAzNywiYXV0aCI6IlJPTEVfQURNSU4gUk9MRV9VU0VSIiwiaWF0IjoxNzAyNDE4NjM3fQ.D8gX4NPfZ8fz-S0u347N3KpMRRLhZaxF5ZTd5F0bDSTvpj5GmNeDpx-XMax4v0dWJ4wBkrPr-48uKmlrQPzKcA',
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