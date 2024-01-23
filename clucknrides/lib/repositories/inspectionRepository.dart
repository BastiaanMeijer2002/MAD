import 'package:clucknrides/models/Inspection.dart';
import 'package:sqflite/sqflite.dart';

class InspectionRepository {
  final Database database;

  InspectionRepository(this.database);

  Future<void> insertInspection(Inspection inspection) async {
    await database.insert('inspections', inspection.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}