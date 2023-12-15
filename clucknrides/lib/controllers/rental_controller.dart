import '../models/Car.dart';
import '../models/Rental.dart';

class RentalController {
  Rental rental;

  RentalController(this.rental);

  bool isAvailable(Car car) {
    return false;
  }

}