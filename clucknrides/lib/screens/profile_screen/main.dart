import 'package:clucknrides/models/Customer.dart';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:clucknrides/screens/profile_screen/active_rentals_widget.dart';
import 'package:clucknrides/screens/profile_screen/finished_rentals_widget.dart';
import 'package:clucknrides/screens/profile_screen/upcoming_rentals_widget.dart';
import 'package:clucknrides/services/authenticationService.dart';
import 'package:clucknrides/services/fetch_customer.dart';
import 'package:clucknrides/widgets/loading_widget/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileWidget extends StatefulWidget {
  final FlutterSecureStorage storage;
  final RentalRepository rentals;
  final CustomerRepository customers;
  final InspectionRepository inspections;

  const ProfileWidget({super.key, required this.storage, required this.rentals, required this.customers, required this.inspections});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();

}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
      body: FutureBuilder(
        future: currentCustomer(widget.storage),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Customer customer = snapshot.data as Customer;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.06,
                    top: screenHeight * 0.03,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Howdy, ${customer.firstName} ${customer.lastName}",
                      style: const TextStyle(
                        fontFamily: "inter",
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: Divider(
                    height: 20,
                    thickness: 1.5,
                    indent: screenWidth * 0.06,
                    endIndent: screenWidth * 0.06,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.02,
                          left: screenWidth * 0.06,
                        ),
                        child: const Text(
                          "Your rentals",
                          style: TextStyle(
                            fontFamily: "inter",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 3,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.02,
                          left: screenWidth * 0.06,
                        ),
                        child: ActiveRentalsWidget(
                          customer: customer,
                          rentals: widget.rentals,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.02,
                          left: screenWidth * 0.06,
                        ),
                        child: UpcomingRentalsWidget(
                          customer: customer,
                          rentals: widget.rentals,
                          storage: widget.storage,
                          inspections: widget.inspections,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.02,
                          left: screenWidth * 0.06,
                        ),
                        child: FinishedRentalsWidget(
                          customer: customer,
                          rentals: widget.rentals, inspections: widget.inspections,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.04),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        fixedSize:
                        MaterialStatePropertyAll(Size(screenWidth * 0.84, screenHeight * 0.05)),
                        backgroundColor: const MaterialStatePropertyAll(Colors.red),
                      ),
                      onPressed: () async {
                        await widget.storage.delete(key: "jwt");
                        if (context.mounted) Navigator.of(context).pushReplacementNamed('start');
                      },
                      child: const Text(
                        "Sign out",
                        style: TextStyle(
                          fontFamily: "inter",
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const LoadingWidget(message: "Loading your profile");
        },
      ),
    );
  }
}
