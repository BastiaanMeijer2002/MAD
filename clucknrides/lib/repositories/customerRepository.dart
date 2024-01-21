import 'package:clucknrides/models/Customer.dart';
import 'package:sqflite/sqflite.dart';

class CustomerRepository {
  final Database database;

  CustomerRepository(this.database);

  Future<void> insertCustomer(Customer customer) async {
    await database.insert('customers', customer.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertCustomers(List<Customer> customerList) async {
    final batch = database.batch();

    for (final customer in customerList) {
      batch.insert('customers', customer.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }


  Future<Customer> currentUser() async {
    final List<Map<String, dynamic>> customer = await database.query('customers', orderBy: "id DESC", limit: 1);
    return Customer.fromJson(customer.first);
  }

  Future<Customer> customer(int id) async {
    final List<Map<String, dynamic>> result = await database.query('customers', where: 'id = ?', whereArgs: [id]);
    return Customer.fromJson(result.first);
  }

}