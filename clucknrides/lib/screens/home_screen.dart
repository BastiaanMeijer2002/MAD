import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f110c),
        title: const Text(
          "Cluck'N'Rides",
          style: TextStyle(
            color: Color(0xfffcf7f7),
            fontFamily: "Inter",
            fontWeight: FontWeight.w600
          )
        )
      ),
      body: const Center(
          child: Text("Hello from home screen")
      ),
    );
  }
}