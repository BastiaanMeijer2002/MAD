import 'package:sqflite/sqlite_api.dart';

import '../models/Car.dart';

class CarRepository {
  final Database database;

  CarRepository(this.database);

  Future<void> insertCars(List<Car> carList) async {
    final batch = database.batch();

    for (final car in carList) {
      batch.insert('cars', car.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  Future<Car> car(int id) async {
    final List<Map<String, dynamic>> result = await database.query('cars', where: 'id = ?', whereArgs: [id]);
    return Car.fromJson(result.first);
  }

  Future<List<Car>> cars() async {
    final List<Map<String, dynamic>> cars = await database.query("cars");
    return cars.map((car) => Car.fromJson(car)).toList();
  }
}