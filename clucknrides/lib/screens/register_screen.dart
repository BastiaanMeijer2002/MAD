import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repositories/carRepository.dart';
import '../repositories/rentalRepository.dart';
import '../services/authenticationService.dart';
import 'login_screen/main.dart';

class RegisterScreen extends StatefulWidget {
  final FlutterSecureStorage storage;
  final CustomerRepository customers;

  const RegisterScreen({Key? key, required this.storage, required this.customers}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Move the TextEditingController instances here
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Widget buildRegistrationForm({
    required TextEditingController usernameController,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required double screenWidth,
  }) {
    return Column(
      children: [
        // Username field
        _buildTextField(
          controller: usernameController,
          label: "Username:",
          hint: "Enter your username",
          screenWidth: screenWidth,
        ),
        // First name field
        _buildTextField(
          controller: firstNameController,
          label: "First Name:",
          hint: "Enter your first name",
          screenWidth: screenWidth,
        ),
        // Last name field
        _buildTextField(
          controller: lastNameController,
          label: "Last Name:",
          hint: "Enter your last name",
          screenWidth: screenWidth,
        ),
        // Email field
        _buildTextField(
          controller: emailController,
          label: "Email:",
          hint: "Enter your email",
          screenWidth: screenWidth,
        ),
        // Password field
        _buildTextField(
          controller: passwordController,
          label: "Password:",
          hint: "Enter your password",
          obscureText: true,
          screenWidth: screenWidth,
        ),
        // Confirm password field
        _buildTextField(
          controller: confirmPasswordController,
          label: "Confirm Password:",
          hint: "Confirm your password",
          obscureText: true,
          screenWidth: screenWidth,
          validator: (value) {
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return '';
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool obscureText = false,
    required double screenWidth,
    String Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
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
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
              ),
              validator: validator,
            ),
          ),
        ],
      ),
    );
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
      body: SingleChildScrollView( // Wrap the Column in a SingleChildScrollView
        child: Form( // Wrap the Column in a Form
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  "howdy, please enter your details below to register an account.",
                  style: TextStyle(
                    fontSize: 20, // Adjusted font size
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Use the buildRegistrationForm method here
              buildRegistrationForm(
                usernameController: usernameController,
                firstNameController: firstNameController,
                lastNameController: lastNameController,
                emailController: emailController,
                passwordController: passwordController,
                confirmPasswordController: confirmPasswordController,
                screenWidth: screenWidth,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          // Call the registerUser service
                          bool isRegistered = await registerUser(
                            username: usernameController.text,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          // If the registration is successful, navigate to the LoginScreen
                          if (isRegistered) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(storage: widget.storage, customers: widget.customers),
                              ),
                            );
                          }
                        } catch (e) {
                          // If the registration fails, show an error dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Registration failed'),
                              content: Text('$e'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                        // If the registration is successful, navigate to the LoginScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(storage: widget.storage, customers: widget.customers),
                          ),
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
        ),
      ),
    );
  }
}
