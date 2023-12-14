import 'package:clucknrides/screens/register_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class StartScreen extends StatelessWidget {
  static const routeName = '/start-screen';

  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Button padding
    final buttonPadding = screenWidth*(0.1/3);

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
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: buttonPadding, right: buttonPadding),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFAD4D8),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        width: screenWidth*0.45,
                        height: 40,
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ]
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, right: buttonPadding),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFAD4D8),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        width: screenWidth*0.45,
                        height: 40,
                        child: const Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    )
                  ]
                )
              )
            ],
          ),
          const Padding(
            padding:    EdgeInsets.only(top: 50),
            child: CircleAvatar(
              radius: 150,
              backgroundImage: AssetImage('assets/images/ChickenAvatar.jpeg'),
            )
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25, left: 60, right: 60),
            child: Column(
              children: [
                Text(
                  "Howdy, Welcome To Cluck'N'Rides!",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                Text(
                  "Log in or sign up today to start using our cars!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
