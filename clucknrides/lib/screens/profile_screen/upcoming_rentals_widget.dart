import 'package:clucknrides/models/Rental.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:clucknrides/screens/car_screen/car_screen_arguments.dart';
import 'package:clucknrides/services/delete_rental.dart';
import 'package:clucknrides/services/fetch_inspections.dart';
import 'package:clucknrides/services/fetch_rentals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/Customer.dart';
import '../../services/check_connection.dart';

class UpcomingRentalsWidget extends StatefulWidget {
  final Customer customer;
  final RentalRepository rentals;
  final FlutterSecureStorage storage;
  final InspectionRepository inspections;

  const UpcomingRentalsWidget({super.key, required this.customer, required this.rentals, required this.storage, required this.inspections});


  @override
  State<UpcomingRentalsWidget> createState() => _UpcomingRentalWidgetState();
}

class _UpcomingRentalWidgetState extends State<UpcomingRentalsWidget> {
  late Future<List<Rental>> _rentalList = Future.value([]);
  bool showList = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final GlobalKey _futureBuilderKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _refreshRentals();
  }

  Future<void> _refreshRentals() async {
    if(await checkInternetConnection()) await fetchRentals(widget.storage, widget.rentals);
    setState(() {
      _rentalList = widget.rentals.upcomingRentals(widget.customer);
    });
  }


  Future<void> _onRefresh() async {
    await _refreshRentals();
    await Future.delayed(const Duration(seconds: 1));
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
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            child: FutureBuilder(
              key: _futureBuilderKey,
              future: _rentalList,
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
                              Navigator.of(context).pushNamed('cars', arguments: CarScreenArguments(car: rentalList[index].car, isFavorite: false, isAvailable: false));
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.cancel_outlined, size: 40,),
                              onPressed: () async {
                                final connectionStatus = await checkInternetConnection();
                                if (connectionStatus) {
                                  await removeRental(widget.storage, widget.rentals, widget.inspections, rentalList[index]);
                                  _refreshIndicatorKey.currentState?.show();
                                } else {
                                  const snackBar = SnackBar(content: Text("You have no connection, please try again if you're connected."));
                                  if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                            ),
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