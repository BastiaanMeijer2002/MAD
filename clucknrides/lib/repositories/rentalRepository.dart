import 'package:clucknrides/models/Rental.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Car.dart';
import '../models/Customer.dart';
import 'carRepository.dart';
import 'customerRepository.dart';

class RentalRepository {
  final Database database;
  final CustomerRepository customers;
  final CarRepository cars;

  RentalRepository(this.database, this.customers, this.cars);

  Future<void> insertRentals(List<Rental> rentalList) async {
    final batch = database.batch();

    for (final rental in rentalList) {
      batch.insert('rentals', rental.toDatabase(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  Future<void> insertRental(Rental rental) async {
    await database.insert('rentals', rental.toDatabase());
  }

  Future<void> updateRental(Rental rental) async {
    await database.update('rentals', rental.toDatabase(), where: 'id = ?', whereArgs: [rental.id]);
  }

  Future<List<Rental>> rentals() async {
    final List<Map<String, dynamic>> rentalsData =
    await database.query("rentals");

    // Convert database data to List of Rental objects with complete Car and Customer
    final List<Rental> rentals = [];
    for (final rentalData in rentalsData) {
      final Rental rental = await _mapToRental(rentalData);
      rentals.add(rental);
    }

    return rentals;
  }

  Future<List<Rental>> carRentals(Car car) async {
    final List<Map<String, dynamic>> rentalsData = await database.query(
      "rentals",
      where: "carId = ?",
      whereArgs: [car.id],
    );

    // Convert database data to List of Rental objects with complete Car and Customer
    final List<Rental> rentals = [];
    for (final rentalData in rentalsData) {
      final Rental rental = await _mapToRental(rentalData);
      rentals.add(rental);
    }

    return rentals;
  }

  Future<Rental> _mapToRental(Map<String, dynamic> rentalData) async {
    final Car car = await cars.car(rentalData['carId']);
    final Customer customer = await customers.customer(rentalData['customerId']);

    print(customer.firstName.toString());

    return Rental.fromJsonWithRelated(rentalData, car: car, customer: customer);
  }

  Future<bool> isActiveRent(Car car, Customer customer) async {
    final List<Map<String, dynamic>> rentalsData = await database.query(
      "rentals",
      where: "carId = ? AND customerId = ? AND state = ?",
      whereArgs: [car.id ?? 0, customer.id ?? 0, "ACTIVE"],
    );

    return rentalsData.isNotEmpty;

  }

  Future<Rental> activeRental(Car car) async {
    final List<Map<String, dynamic>> rentalsData = await database.query(
      "rentals",
      where: "carId = ? AND state = ?",
      whereArgs: [car.id, "ACTIVE"],
    );

    final List<Rental> rentals = [];
    for (final rentalData in rentalsData) {
      final Rental rental = await _mapToRental(rentalData);
      rentals.add(rental);
    }

    return rentals.first;
  }
}
