import 'package:clucknrides/models/Car.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clucknrides/utils/database.dart';
import 'package:clucknrides/repositories/carRepository.dart';

void sqfliteTestInit() {

  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

void main() {
  sqfliteTestInit();
  late Database db;
  late DatabaseProvider databaseProvider;

  setUp(() async {
    databaseProvider = DatabaseProvider();
    db = await databaseProvider.initDatabase();
  });

  // Test database creation
  test('test if all tables are created', () async {
    List<String> tables = ['cars', 'customers', 'rentals', 'inspections'];
    for (var table in tables) {
      var res = await db.query(table);
      // If the table does not exist, this query will throw an exception
      expect(res, isNotNull);
    }
  });

  // Test CRUD operations in carRepository.dart
  group('test CRUD operations in carRepository.dart', () {
    test('test for insertCars', () async {
      var carRepository = CarRepository(db);
      var cars = [
        Car(
            id: 1,
            brand: 'test1',
            model: 'test1',
            nrOfSeats: 5,
            fuel: 'test1',
            img: 'test1',
            price: 100,
            engineSize: 5,
            modelYear: 2021,
            longitude: 0,
            latitude: 0),
        Car(
            id: 2,
            brand: 'test2',
            model: 'test2',
            nrOfSeats: 5,
            fuel: 'test2',
            img: 'test2',
            price: 100,
            engineSize: 5,
            modelYear: 2021,
            longitude: 0,
            latitude: 0)
      ];
      await carRepository.insertCars(cars);
      var res = await db.query('cars');
      expect(res.length, 2);
    });

    test('test for car', () async {
      var carRepository = CarRepository(db);
      var car = Car(
          id: 1,
          brand: 'test1',
          model: 'test1',
          nrOfSeats: 5,
          fuel: 'test1',
          img: 'fiesta.png',
          price: 100,
          engineSize: 5,
          modelYear: 2021,
          longitude: 0,
          latitude: 0);
      var res = await carRepository.car(1);
      expect(res.toJson(), car.toJson());
    });

    test('test for cars', () async {
      var carRepository = CarRepository(db);
      var cars = [
        Car(
            id: 1,
            brand: 'test1',
            model: 'test1',
            nrOfSeats: 5,
            fuel: 'test1',
            img: 'fiesta.png',
            price: 100,
            engineSize: 5,
            modelYear: 2021,
            longitude: 0,
            latitude: 0),
        Car(
            id: 2,
            brand: 'test2',
            model: 'test2',
            nrOfSeats: 5,
            fuel: 'test2',
            img: 'fiesta.png',
            price: 100,
            engineSize: 5,
            modelYear: 2021,
            longitude: 0,
            latitude: 0)
      ];
      var res = await carRepository.cars();
      List<Map<String, dynamic>> testCars = cars.map((car) => car.toJson()).toList();
      List<Map<String, dynamic>> testRes = res.map((car) => car.toJson()).toList();
      expect(testRes, testCars);
    });
  });

  tearDown(() async {
    await db.close();
  });
}