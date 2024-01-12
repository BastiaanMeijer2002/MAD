import 'package:clucknrides/screens/home_screen/main.dart';
import 'package:clucknrides/screens/start_screen.dart';
import 'package:clucknrides/utils/database.dart';
import 'package:clucknrides/widgets/loading_widget/main.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = await DatabaseProvider().initDatabase();
  runApp(MyApp(database: database,));
}

class MyApp extends StatelessWidget {
  final Database database;

  const MyApp({super.key, required this.database});
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
      home: const StartScreen(storage: storage),
    );
  }
}

