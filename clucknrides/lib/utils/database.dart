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
          await db.execute('CREATE TABLE cars (id INTEGER PRIMARY KEY UNIQUE, brand TEXT, model TEXT, fuel TEXT, options TEXT, licensePlate TEXT, engineSize INTEGER, modelYear INTEGER, since TEXT, price INTEGER, nrOfSeats INTEGER, body TEXT, img TEXT,longitude REAL,latitude REAL);');
          await db.execute('CREATE TABLE customers (id INTEGER PRIMARY KEY UNIQUE, number INTEGER, lastName TEXT, firstName TEXT, "from" TEXT);');
          await db.execute('CREATE TABLE rentals (id INTEGER PRIMARY KEY UNIQUE,code TEXT,longitude REAL,latitude REAL,fromDate TEXT,toDate TEXT,state TEXT,carId INTEGER,customerId INTEGER,FOREIGN KEY (carId) REFERENCES cars(id),FOREIGN KEY (customerId) REFERENCES customers(id));');
          await db.execute('CREATE TABLE inspections (id INTEGER PRIMARY KEY, code TEXT, odometer INTEGER, result TEXT, photo TEXT, photoContentType TEXT, completed TEXT, rentalId INTEGER, FOREIGN KEY (rentalId) REFERENCES rentals(id));');
        },
        version: 3,
      );
      return database;
    } catch (e) {
      print('Error initializing database: $e');
      rethrow; // Rethrow the exception to see the full error details
    }
  }

}
