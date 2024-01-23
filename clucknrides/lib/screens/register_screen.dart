import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repositories/carRepository.dart';
import '../repositories/rentalRepository.dart';
import 'login_screen/main.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register-screen';
  final FlutterSecureStorage storage;
  final CustomerRepository customers;
  final RentalRepository rentals;
  final CarRepository cars;

  const RegisterScreen({Key? key, required this.storage, required this.customers, required this.rentals, required this.cars}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              "Howdy, please enter your details below to register an account.",
              style: TextStyle(
                fontSize: 20, // Adjusted font size
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Name:",
                  style: TextStyle(
                    fontSize: 18, // Adjusted font size
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your name",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email:",
                  style: TextStyle(
                    fontSize: 18, // Adjusted font size
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your email",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Password:",
                  style: TextStyle(
                    fontSize: 18, // Adjusted font size
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your password",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Confirm Password:",
                  style: TextStyle(
                    fontSize: 18, // Adjusted font size
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: screenWidth * 0.9,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Confirm your password",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  // onTap: () {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       // builder: (context) => LoginScreen(storage: storage, customers: customers, rentals: rentals, cars: cars, inspections: inspections,)
                  //     ),
                  //   );
                  // },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFAD4D8),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    width: screenWidth * 0.9,
                    height: 40,
                    child: const Center(
                      child: Text(
                        "Start Riding!",
                        style: TextStyle(
                          fontSize: 18, // Adjusted font size
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
