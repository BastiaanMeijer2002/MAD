import 'package:clucknrides/screens/car_screen/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import '../../../models/Car.dart';

class ListItem extends StatefulWidget {
  final Car car;
  final bool isAvailable;
  final Position? location;


  const ListItem(this.car, this.isAvailable, {Key? key, this.location}) : super(key: key);

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
      ) / 1000;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarScreen(
              car: widget.car,
              isFavorite: false,
              isAvailable: widget.isAvailable,
            ),
          ),
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
            margin: const EdgeInsets.only(left: 27, top: 0, bottom: 23, right: 0),
            width: 373,
            height: 242,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 105,
                  height: 30,
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
                    width: 500,
                    height: 154,
                  ),
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  height: 56,
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
                        margin: const EdgeInsets.only(left: 17),
                        child: Text(
                          widget.car.name,
                          style: const TextStyle(
                            color: Color(0xFFF1ECEC),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 9),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/people.svg',
                              width: 24,
                              height: 24,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: Text(
                                widget.car.capacity.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFF1ECEC),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Row(
                                children: [
                                  Image.asset('assets/icons/location.png'),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 7),
                                    child: Text(
                                      "${_calculateDistance()!.toStringAsFixed(1)} KM",
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
