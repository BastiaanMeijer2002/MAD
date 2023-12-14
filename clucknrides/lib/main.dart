import 'package:clucknrides/screens/home_screen/main.dart';
import 'package:clucknrides/screens/start_screen.dart';
import 'package:dotenv/dotenv.dart';
import 'package:flutter/material.dart';

void main() {
  DotEnv().load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Cluck'N'Rides",
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFD6FFB7),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartScreen(),
    );
  }
}

