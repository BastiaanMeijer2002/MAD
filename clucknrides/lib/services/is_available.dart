import 'package:clucknrides/services/fetch_rentals.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/Car.dart';
import '../models/Rental.dart';
import '../repositories/rentalRepository.dart';

Future<bool> isAvailable(FlutterSecureStorage storage,RentalRepository rentals, Car car) async {
  List<Rental> rentalList = await rentals.carRentals(car);
  // List<Rental> rentalList = await fetchRentals(storage, rentals);
  for (Rental rental in rentalList) {
    print('rental ${rental.car.id} car ${car.id}');
    if (rental.car.id == car.id && rental.state != "RETURNED"){
      return false;
    }
    // if (rental.car.toJson().toString() == car.toJson().toString() && rental.state != "RETURNED") {
    //   print("false");
    //   return false;
    // }
  }

  return true;
}
