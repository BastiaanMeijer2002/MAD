import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {

  Future<Database> initDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      print(join(await getDatabasesPath(), 'data.db'),);
      final database = await openDatabase(
        join(await getDatabasesPath(), 'data.db'),
        onCreate: (db, version) async{
          await db.execute('CREATE TABLE rentals (id INTEGER PRIMARY KEY, code TEXT, longitude REAL, latitude REAL, fromDate TEXT, toDate TEXT, state TEXT, carId INTEGER, FOREIGN KEY (carId) REFERENCES cars(id));');
          await db.execute('CREATE TABLE cars (id INTEGER PRIMARY KEY, brand TEXT, model TEXT, fuel TEXT, options TEXT, licensePlate TEXT, engineSize INTEGER, modelYear INTEGER, since TEXT, price INTEGER, nrOfSeats INTEGER, body TEXT);');
        },
        version: 2,
      );
      return database;
    } catch (e) {
      print('Error initializing database: $e');
      rethrow; // Rethrow the exception to see the full error details
    }
  }

}
