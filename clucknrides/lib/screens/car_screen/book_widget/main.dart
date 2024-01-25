import 'package:clucknrides/models/Customer.dart';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:clucknrides/screens/car_screen/book_widget/calender_widget.dart';
import 'package:clucknrides/services/authenticationService.dart';
import 'package:clucknrides/services/create_booking.dart';
import 'package:clucknrides/services/fetch_customer.dart';
import 'package:clucknrides/services/fetch_rentals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../models/Car.dart';
import '../../../models/Rental.dart';

class BookWidget extends StatefulWidget {
  final RentalRepository rentals;
  final CustomerRepository customers;
  final FlutterSecureStorage storage;
  final Car car;

  const BookWidget({super.key, required this.rentals, required this.car, required this.storage, required this.customers});

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
  DateTime? _start;
  DateTime? _end;

  @override
  void initState() {
    super.initState();
  }

  void startModel() {
    if (context.mounted) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF9BBFB9),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Book this car for later',
                      style: TextStyle(
                        fontFamily: "inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                    future: widget.rentals.unavailableDays(widget.car),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CalenderWidget(
                          unavailableDays: snapshot.data as List<DateTime>,
                          onRangeSelect: (DateTime? start, DateTime? end) {
                            setState(() {
                              _start = start;
                              _end = end;
                            });
                          },
                        );
                      }
                      return Container();
                    }
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
                            OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "inter",
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
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
                              onPressed: () async {
                                Rental rental = await createBooking(widget.storage, widget.car, widget.customers,widget.rentals, _start!, _end);
                                if (context.mounted) {
                                  Navigator.pop(context);
                                  activeModel(rental);
                                }
                              },
                              child: const Text(
                                'Book car',
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
                )
              ],
            )
          );
        },
      );
    }
  }

  void activeModel(Rental rental) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.22,
            decoration: const BoxDecoration(
              color: Color(0xFF9BBFB9),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Your booking',
                      style: TextStyle(
                        fontFamily: "inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'You have booked this car from ${rental.fromDate} until ${rental.toDate}',
                      style: const TextStyle(
                        fontFamily: "inter",
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      maxLines: 6,
                    ),
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  Future<void> getModal() async{
    await fetchRentals(widget.storage, widget.rentals);
    Customer customer = await currentCustomer(widget.storage);
    Rental? rental = await widget.rentals.activeBooking(widget.car, customer);

    if (rental != null) {
      activeModel(rental);
    } else {
      startModel();
    }

  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async{
        await getModal();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.032, right: screenWidth * 0.035),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF9BBFB9),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          width: screenWidth * 0.444,
          height: screenHeight * 0.043,
          child: Center(
            child: Text(
              "Book for later",
              style: TextStyle(
                fontSize: screenWidth * 0.056,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
        ),
      ),
    );
  }
}