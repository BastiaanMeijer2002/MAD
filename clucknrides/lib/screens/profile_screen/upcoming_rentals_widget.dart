import 'package:clucknrides/models/Rental.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:flutter/material.dart';

import '../../models/Customer.dart';

class UpcomingRentalsWidget extends StatefulWidget {
  final Customer customer;
  final RentalRepository rentals;

  const UpcomingRentalsWidget({super.key, required this.customer, required this.rentals});


  @override
  State<UpcomingRentalsWidget> createState() => _UpcomingRentalWidgetState();
}

class _UpcomingRentalWidgetState extends State<UpcomingRentalsWidget>{
  bool showList = false;

  @override
  Widget build(BuildContext context) {
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
                  "Upcoming Rentals",
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
            future: widget.rentals.upcomingRentals(widget.customer),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Rental> rentalList = snapshot.data as List<Rental>;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: rentalList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(rentalList[index].car.model),
                      subtitle: Text('Start Date: ${rentalList[index].fromDate}'),
                      // Add more details as needed
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