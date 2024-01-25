import 'package:clucknrides/models/Rental.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:clucknrides/screens/car_screen/car_screen_arguments.dart';
import 'package:flutter/material.dart';

import '../../models/Customer.dart';

class ActiveRentalsWidget extends StatefulWidget {
  final Customer customer;
  final RentalRepository rentals;

  const ActiveRentalsWidget({super.key, required this.customer, required this.rentals});


  @override
  State<ActiveRentalsWidget> createState() => _ActiveRentalWidgetState();
}

class _ActiveRentalWidgetState extends State<ActiveRentalsWidget>{
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              setState(() {
                showList = !showList;
              });
            },
            child: Row(
              children: [
                Icon(showList ? Icons.arrow_drop_down : Icons.arrow_right, size: 36,),
                const SizedBox(width: 10,),
                const Text(
                  "Active Rentals",
                  style: TextStyle(
                    fontFamily: "inter",
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: showList,
          child: FutureBuilder(
            future: widget.rentals.activeRentals(widget.customer),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Rental> rentalList = snapshot.data as List<Rental>;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: rentalList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02, right: screenWidth * 0.06,),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0)
                        ),
                        child: ListTile(
                          tileColor: const Color(0XFFFAD4D8),
                          title: Text('${rentalList[index].car.brand} ${rentalList[index].car.model}'),
                          subtitle: Text('Start Date: ${rentalList[index].fromDate}'),
                          onTap: () {
                            Navigator.of(context).pushNamed('cars', arguments: CarScreenArguments(car: rentalList[index].car, isFavorite: false, isAvailable: false));
                          },
                        ),
                      ),
                    );
                  },
                );
              }
              return const Text("test");
            },
          ),
        ),
      ],
    );
  }
}