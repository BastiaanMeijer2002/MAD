import 'package:clucknrides/services/fetch_rentals.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/Car.dart';
import '../models/Rental.dart';

Future<bool> isAvailable(FlutterSecureStorage storage, Car car) async {
  List<Rental> rentals = await fetchRentals(storage);

  for (Rental rental in rentals) {
    if (rental.car.toJson().toString() == car.toJson().toString() && rental.state != "RETURNED") {
      return false;
    }
  }

  return true;
}