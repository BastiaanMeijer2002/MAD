import 'dart:io';

import 'package:clucknrides/repositories/carRepository.dart';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/screens/password_reset_screen.dart';
import 'package:clucknrides/services/authenticationService.dart';
import 'package:clucknrides/widgets/errors/invalid_credentials_error.dart';
import 'package:clucknrides/widgets/errors/server_error.dart';
import 'package:clucknrides/widgets/loading_widget/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../repositories/rentalRepository.dart';
import '../home_screen/main.dart';

class LoginScreen extends StatefulWidget {
  final FlutterSecureStorage storage;
  final CustomerRepository customers;


  const LoginScreen({Key? key, required this.storage, required this.customers}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Future<bool> jwt;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> loginUser() async {
    jwt = authenticateUser(userNameController.text, passwordController.text, widget.storage, widget.customers);
    return jwt;
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              "Howdy, please enter your credentials to login.",
              style: TextStyle(
                fontSize: 20,
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
                  "Username:",
                  style: TextStyle(
                    fontSize: 18,
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
                  child: Center(
                    child: TextField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your username",
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
                    fontSize: 18,
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
                  child: Center(
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
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
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FutureBuilder<bool>(
                          future: loginUser(),
                          builder: (context, snapshot) {
                            print(snapshot.error);
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const LoadingWidget(message: "Howdy, welcome back!");
                            } else if (snapshot.hasData && snapshot.data!) {
                              Future.delayed(Duration.zero, () {
                                Navigator.of(context).pushReplacementNamed('home');
                              });
                              return const SizedBox.shrink();
                            } else if (snapshot.hasError && snapshot.error is HttpException) {
                              return const InvalidCredentialsError();
                            } else {
                              return const ServerError();
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFFAD4D8),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    width: screenWidth * 0.9,
                    height: 40,
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('password_reset');
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.blue,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
