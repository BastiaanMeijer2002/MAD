import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:clucknrides/services/authenticationService.dart'; // Import your authentication service

class PasswordResetScreen extends StatefulWidget {
  final FlutterSecureStorage storage;

  const PasswordResetScreen({Key? key, required this.storage}) : super(key: key);

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  TextEditingController emailController = TextEditingController();

  Future<void> _resetPassword() async {
    try {
      bool result = await forgotPassword(emailController.text);
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password reset email sent.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send password reset email.")),
        );
      }
    } catch (e) {
      // Handle the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred.")),
      );
    }
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
              "howdy, please enter your email.",
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
                  child: Center(
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter your email",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              "You will receive an email with instructions on how to reset your password.",
              style: TextStyle(
                fontSize: 20, // Adjusted font size
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _resetPassword();
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
                          fontSize: 18, // Adjusted font size
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class PasswordResetScreen extends StatelessWidget {
//   static const routeName = '/password-reset-screen';
//
//   const PasswordResetScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xff0f110c),
//         title: const Text(
//           "Cluck'N'Rides",
//           style: TextStyle(
//             color: Color(0xfffcf7f7),
//             fontFamily: "Inter",
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(top: 20, left: 20, right: 20),
//             child: Text(
//               "howdy, please enter your email.",
//               style: TextStyle(
//                 fontSize: 20, // Adjusted font size
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Email:",
//                   style: TextStyle(
//                     fontSize: 18, // Adjusted font size
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Container(
//                   width: screenWidth * 0.9,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: const Center(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Enter your email",
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 20, left: 20, right: 20),
//             child: Text(
//               "You will receive an email with instructions on how to reset your password.",
//               style: TextStyle(
//                 fontSize: 20, // Adjusted font size
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Color(0xFFFAD4D8),
//                       borderRadius: BorderRadius.all(Radius.circular(8)),
//                     ),
//                     width: screenWidth * 0.9,
//                     height: 40,
//                     child: const Center(
//                       child: Text(
//                         "Login",
//                         style: TextStyle(
//                           fontSize: 18, // Adjusted font size
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
