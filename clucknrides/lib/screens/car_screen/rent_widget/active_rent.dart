import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../models/Car.dart';
import '../../../repositories/customerRepository.dart';
import '../../../repositories/rentalRepository.dart';
import '../../../services/startRent.dart';

class ActiveRental extends StatefulWidget {
  final FlutterSecureStorage storage;
  final Car car;
  final CustomerRepository customers;
  final RentalRepository rentals;

  const ActiveRental({super.key, required this.storage, required this.car, required this.customers, required this.rentals});

  @override
  State<ActiveRental> createState() => _ActiveRentalState();
}

class _ActiveRentalState extends State<ActiveRental>{
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double modelHeight = 0.57;


    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.032, left: screenWidth * 0.035, right: screenWidth * 0.035),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: screenHeight * modelHeight,
                decoration: const BoxDecoration(
                  color: Color(0XFFFAD4D8),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Currently renting',
                              style: TextStyle(
                                fontFamily: "inter",
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(const Color(0XFF0F110C)),
                                    foregroundColor: MaterialStateProperty.all(const Color(0XFFFFFCFC)),
                                    textStyle: MaterialStateProperty.all(
                                      const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "inter",
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFFFFFCFC),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {  },
                                  child: const Text(
                                    'Start renting',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "inter",
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0XFF0F110C)),
            foregroundColor: MaterialStateProperty.all(const Color(0XFFFFFCFC)),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                fontSize: 18,
                fontFamily: "inter",
                fontWeight: FontWeight.w600,
                color: Color(0XFFFFFCFC),
              ),
            ),
          ),
          onPressed: () async {
            await startRent(widget.storage, widget.car, widget.customers, widget.rentals);
            return Navigator.pop(context);
          },
          child: const Text(
            'Start renting',
            style: TextStyle(
              fontSize: 18,
              fontFamily: "inter",
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        )
      ),
    );
  }
}