// import 'dart:io';
//
// import 'package:clucknrides/models/Rental.dart';
// import 'package:clucknrides/repositories/rentalRepository.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// Future<void> removeRental(FlutterSecureStorage storage, RentalRepository rentals, Rental rental) async {
//   final jwt = await storage.read(key: "jwt");
//   final response = await http.get(
//     Uri.parse('${dotenv.env["API_BASE_URL"]}/api/rentals'),
//     headers: {
//       HttpHeaders.authorizationHeader: 'Bearer $jwt',
//     },
//   );
//
//   if (response.statusCode == 200) {
//
//   } else {
//     throw HttpException('${response.statusCode}: ${response.body}');
//   }
// }