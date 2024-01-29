import 'dart:convert';

import 'package:clucknrides/models/Inspection.dart';
import 'package:clucknrides/models/Rental.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:flutter/material.dart';

import '../../models/Customer.dart';

class FinishedRentalsWidget extends StatefulWidget {
  final Customer customer;
  final RentalRepository rentals;
  final InspectionRepository inspections;

  const FinishedRentalsWidget({super.key, required this.customer, required this.rentals, required this.inspections});


  @override
  State<FinishedRentalsWidget> createState() => _FinishedRentalWidgetState();
}

class _FinishedRentalWidgetState extends State<FinishedRentalsWidget>{
  bool showList = false;

  void rentalModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0XFFFAD4D8),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          )
        );
      }
    );
  }


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
                  "Finished Rentals",
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
        SingleChildScrollView(
          child: Visibility(
            visible: showList,
            child: FutureBuilder(
              future: widget.rentals.finishedRentals(widget.customer),
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
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('From: ${rentalList[index].fromDate}'),
                                Text('Until: ${rentalList[index].toDate}')
                              ],
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return SingleChildScrollView(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Color(0XFFFAD4D8),
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                                      ),
                                      height: 2*screenHeight,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
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
                                          const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Divider(
                                              height: 20,
                                              thickness: 1.5,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(14.0),
                                              child: Text(
                                                'Start date: ${rentalList[index].fromDate}',
                                                style: const TextStyle(
                                                  fontFamily: "inter",
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Text(
                                                'End date: ${rentalList[index].toDate}',
                                                style: const TextStyle(
                                                  fontFamily: "inter",
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(16.0),
                                              child: Text(
                                                'Car: ${rentalList[index].car.brand} ${rentalList[index].car.model} ${rentalList[index].car.modelYear}',
                                                style: const TextStyle(
                                                  fontFamily: "inter",
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Divider(
                                              height: 20,
                                              thickness: 1.5,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Text(
                                              'Reported damage',
                                              style: TextStyle(
                                                fontFamily: "inter",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          FutureBuilder(
                                            future: widget.inspections.rentalInspection(rentalList[index]),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                Inspection inspection = snapshot.data as Inspection;
                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.all(16.0),
                                                      child: Text(
                                                        'Description',
                                                        style: TextStyle(
                                                          fontFamily: "inter",
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Text(
                                                        inspection.result,
                                                        style: const TextStyle(
                                                          fontFamily: "inter",
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(16.0),
                                                      child: Image.memory(base64Decode(inspection.photo)),
                                                    ),
                                                  ],
                                                );
                                              }
                                              return const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text("No damage reported"),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ],
    );
  }
}