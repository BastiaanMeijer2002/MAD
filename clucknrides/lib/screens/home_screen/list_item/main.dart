import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/screens/car_screen/car_screen_arguments.dart';
import 'package:clucknrides/screens/car_screen/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import '../../../models/Car.dart';
import '../../../repositories/rentalRepository.dart';

class ListItem extends StatefulWidget {
  final Car car;
  final bool isAvailable;
  final Position? location;
  final RentalRepository rentals;
  final CustomerRepository customers;
  final InspectionRepository inspections;
  final FlutterSecureStorage storage;


  const ListItem(this.car, this.isAvailable, {Key? key, this.location, required this.rentals, required this.customers, required this.storage, required this.inspections}) : super(key: key);

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  double distanceToA = 0.0; // Initialize with a default value

  @override
  void initState() {
    super.initState();
    // Perform the distance calculation when the widget is initialized
    _calculateDistance();
  }

  double? _calculateDistance() {
    if (widget.location != null) {
      return Geolocator.distanceBetween(
        widget.location!.latitude,
        widget.location!.longitude,
        widget.car.latitude,
        widget.car.longitude,
      ) /
          1000;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          'cars',
          arguments: CarScreenArguments(car: widget.car, isFavorite: false, isAvailable: widget.isAvailable)
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: widget.isAvailable
                  ? const Color(0xFFFAD4D8)
                  : const Color(0xFF9BBFB9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF0F110C),
                width: 1.0,
              ),
            ),
            margin: EdgeInsets.only(
              left: screenWidth * 0.063,
              top: 0,
              bottom: screenHeight * 0.025,
              right: 0,
            ),
            width: screenWidth * 0.871,
            height: screenHeight * 0.262,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * 0.245,
                  height: screenHeight * 0.032,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F110C),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.isAvailable ? "Available" : "Not available",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFFF1ECEC),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/images/${widget.car.img}',
                    width: screenWidth * 0.539, // 500 / 926
                    height: screenHeight * 0.166, // 154 / 926
                  ),
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  height: screenHeight * 0.0605, // 56 / 926
                  decoration: const BoxDecoration(
                    color: Color(0xFF0F110C),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: screenWidth * 0.040), // 17 / 926
                        child: Text(
                          '${widget.car.brand} ${widget.car.model}',
                          style: const TextStyle(
                            color: Color(0xFFF1ECEC),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.020), // 9 / 926
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/people.svg',
                              width: screenWidth * 0.026, // 24 / 926
                              height: screenHeight * 0.026, // 24 / 926
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.007), // 7 / 926
                              child: Text(
                                widget.car.nrOfSeats.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFF1ECEC),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.014), // 14 / 926
                              child: Row(
                                children: [
                                  Image.asset('assets/icons/location.png'),
                                  Padding(
                                    padding: EdgeInsets.only(left: screenWidth * 0.007), // 7 / 926
                                    child: Text(
                                      "${_calculateDistance()?.toStringAsFixed(1) ?? 0.0} KM",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFF1ECEC),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
