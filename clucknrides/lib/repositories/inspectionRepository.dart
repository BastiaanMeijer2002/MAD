import 'package:clucknrides/models/Inspection.dart';
import 'package:clucknrides/models/Rental.dart';
import 'package:sqflite/sqflite.dart';

class InspectionRepository {
  final Database database;

  InspectionRepository(this.database);

  Future<void> insertInspection(Inspection inspection) async {
    await database.insert('inspections', inspection.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertInspections(List<Inspection> inspectionList) async {
    final batch = database.batch();

    final existingInspections = await database.query('inspections');

    for (final existingInspection in existingInspections) {
      final existingId = existingInspection['id'];
      final existingIndex = inspectionList.indexWhere((inspection) => inspection.id == existingId);

      if (existingIndex == -1) {
        batch.delete('inspections', where: 'id = ?', whereArgs: [existingId]);
      }
    }

    for (final inspection in inspectionList) {
      batch.insert('inspections', inspection.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }


  Future<Inspection?> rentalInspection(Rental rental) async {
    List<Map<String,dynamic>> result = await database.query('inspections', where: "rentalId = ?", whereArgs: [rental.id]);

    if (result.isNotEmpty) return Inspection.fromJson(result.first);

    return null;
  }
}