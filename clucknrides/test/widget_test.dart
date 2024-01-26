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

class MockCarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mock Car Screen'),
      ),
      body: Center(
        child: Text('This is a mock car screen'),
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ListItem Widget Tests', () {
    testWidgets('Renders with correct data', (WidgetTester tester) async {
      final mockRentals = MockRentalRepository();
      final mockCustomers = MockCustomerRepository();
      final mockInspections = MockInspectionRepository();
      final mockStorage = MockFlutterSecureStorage();

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

      // Car name
      expect(find.text('Toyota Corolla'), findsOneWidget);

      // Number of seats
      expect(find.text('5'), findsOneWidget);

      // Images
      expect(find.byType(Image), findsNWidgets(2));
    });

  //   testWidgets('Navigates to CarScreen on tap', (WidgetTester tester) async {
  //     // Mock necessary dependencies
  //     final mockRentals = MockRentalRepository();
  //     final mockCustomers = MockCustomerRepository();
  //     final mockInspections = MockInspectionRepository();
  //     final mockStorage = MockFlutterSecureStorage();
  //
  //     final mockObserver = MockNavigatorObserver();
  //
  //     final exampleCar = Car(
  //       id: 1,
  //       brand: 'Toyota',
  //       model: 'Corolla',
  //       nrOfSeats: 5,
  //       fuel: 'Petrol',
  //       img: 'fiesta.png', // Here, 'car.png' is just a placeholder
  //       price: 20000,
  //       engineSize: 1800,
  //       modelYear: 2021,
  //       longitude: 0.0,
  //       latitude: 0.0,
  //     );
  //
  //     await tester.pumpWidget(MaterialApp(
  //       home: ListItem(
  //         exampleCar,
  //         true,
  //         rentals: mockRentals,
  //         customers: mockCustomers,
  //         inspections: mockInspections,
  //         storage: mockStorage,
  //       ),
  //       navigatorObservers: [mockObserver],
  //       routes: {
  //         'cars': (context) => MockCarScreen(),
  //       },
  //     ));
  //
  //     await tester.tap(find.byType(GestureDetector));
  //     await tester.pumpAndSettle();
  //
  //     // Assert that the navigation occurred.
  //     // This part depends on your navigation setup.
  //     verify(mockObserver.didPush(any, any));
  //   });
  });
}
