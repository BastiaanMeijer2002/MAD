import 'package:flutter/material.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  State<CarScreen> createState() => _CarScreenState();

}

class _CarScreenState extends State<CarScreen> {

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
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: const Text("welcome to carscreen")
    );
  }
}