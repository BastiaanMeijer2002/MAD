import 'package:clucknrides/repositories/carRepository.dart';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:clucknrides/screens/home_screen/main.dart';
import 'package:clucknrides/screens/login_screen/main.dart';
import 'package:clucknrides/screens/profile_screen/main.dart';
import 'package:clucknrides/screens/register_screen.dart';
import 'package:clucknrides/screens/start_screen.dart';
import 'package:clucknrides/utils/database.dart';
import 'package:clucknrides/widgets/loading_widget/main.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  final database = await DatabaseProvider().initDatabase();
  final CustomerRepository customers = CustomerRepository(database);
  final CarRepository cars = CarRepository(database);
  final RentalRepository rentals = RentalRepository(database, customers, cars);
  final InspectionRepository inspections = InspectionRepository(database);
  await dotenv.load(fileName: "lib/.env");
  runApp(MyApp(database: database, customerRepository: customers, rentalRepository: rentals, carRepository: cars, inspectionRepository: inspections,));
}

class MyApp extends StatelessWidget {
  final Database database;
  final CustomerRepository customerRepository;
  final RentalRepository rentalRepository;
  final CarRepository carRepository;
  final InspectionRepository inspectionRepository;


  const MyApp({super.key, required this.database, required this.customerRepository, required this.rentalRepository, required this.carRepository, required this.inspectionRepository});
  static const storage = FlutterSecureStorage();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cluck'N'Rides",
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFD6FFB7),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (BuildContext context) {
          return FutureBuilder<String?>(
            future: storage.read(key: 'jwt'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData && snapshot.data != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacementNamed('home');
                  });
                }
                return const StartScreen();
              } else {
                return const LoadingWidget(message: 'Welcome back');
              }
            },
          );
        },
      ),
      routes: {
        'home': (context) => HomeScreen(storage: storage, rentals: rentalRepository, customers: customerRepository, cars: carRepository, inspections: inspectionRepository),
        'login': (context) => LoginScreen(storage: storage, customers: customerRepository),
        'register': (context) => RegisterScreen(storage: storage, customers: customerRepository),
        'profile': (context) => ProfileWidget(storage: storage, rentals: rentalRepository, customers: customerRepository,),
        'start': (context) => const StartScreen(),
      },
    );
  }
}

