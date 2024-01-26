import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clucknrides/models/Car.dart';
import 'package:clucknrides/screens/home_screen/list_item/main.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRentalRepository extends Mock implements RentalRepository {}
class MockCustomerRepository extends Mock implements CustomerRepository {}
class MockInspectionRepository extends Mock implements InspectionRepository {}
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ListItem Widget Tests', () {
    testWidgets('Renders with correct data', (WidgetTester tester) async {
      final exampleCar = Car(
        id: 1,
        brand: 'Toyota',
        model: 'Corolla',
        nrOfSeats: 5,
        fuel: 'Petrol',
        img: 'fiesta.png', // Here, 'car.png' is just a placeholder
        price: 20000,
        engineSize: 1800,
        modelYear: 2021,
        longitude: 0.0,
        latitude: 0.0,
      );

      final mockRentals = MockRentalRepository();
      final mockCustomers = MockCustomerRepository();
      final mockInspections = MockInspectionRepository();
      final mockStorage = MockFlutterSecureStorage();

      await tester.pumpWidget(MaterialApp(
        home: ListItem(
          exampleCar,
          true,
          rentals: mockRentals,
          customers: mockCustomers,
          inspections: mockInspections,
          storage: mockStorage,
        ),
      ));

      expect(find.text('Toyota Corolla'), findsOneWidget);
      // Additional assertions as necessary
    });
  });
}
