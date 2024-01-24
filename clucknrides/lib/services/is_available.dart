import 'package:clucknrides/services/fetch_rentals.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/Car.dart';
import '../models/Rental.dart';
import '../repositories/rentalRepository.dart';

Future<bool> isAvailable(FlutterSecureStorage storage,RentalRepository rentals, Car car) async {
  List<Rental> rentalList = await rentals.carRentals(car);

  for (Rental rental in rentalList) {
    switch (rental.state) {
      case "ACTIVE":
        return false;
      case "RESERVED":
        if (DateTime.parse(rental.fromDate).compareTo(DateTime.now()) < 0 && DateTime.parse(rental.toDate).compareTo(DateTime.now()) > 0) return false;
    }
  }
  return true;
}
