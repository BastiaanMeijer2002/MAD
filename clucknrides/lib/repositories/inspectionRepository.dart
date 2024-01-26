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

    final existingInspections = await database.query('inspections', columns: ["id"]);

    final existingIds = Set<int>.from(existingInspections.map((inspection) => inspection['id']));

    for (final inspection in inspectionList) {
      final inspectionId = inspection.id;

      if (existingIds.contains(inspectionId)) {
        batch.update('inspections', inspection.toJson(),
            where: 'id = ?', whereArgs: [inspectionId]);
      } else {
        batch.insert('inspections', inspection.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    for (final existingInspection in existingInspections) {
      final existingId = existingInspection['id'];

      if (!existingIds.contains(existingId)) {
        batch.delete('inspections', where: 'id = ?', whereArgs: [existingId]);
      }
    }

    await batch.commit(noResult: true);
  }


  Future<Inspection?> rentalInspection(Rental rental) async {
    List<Map<String,dynamic>> result = await database.query('inspections', where: "rentalId = ?", whereArgs: [rental.id]);

    if (result.isNotEmpty) return Inspection.fromJson(result.first);

    return null;
  }
}