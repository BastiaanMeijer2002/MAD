import 'package:flutter/material.dart';
import '../../models/Car.dart';

class CarScreen extends StatefulWidget {
  final Car car;

  const CarScreen({Key? key, required this.car}) : super(key: key);

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f110c),
        title: Builder(
          builder: (BuildContext context) {
            return Text(
              "Rent ${widget.car.name}",
              style: const TextStyle(
                color: Color(0xfffcf7f7),
                fontFamily: "Inter",
                fontWeight: FontWeight.w600,
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 286,
            color: const Color(0xFFFAD4D8),
            child: Center(child: Image.asset('assets/images/${widget.car.img}')),
          ),
          Container(
            width: double.infinity,
            height: 56,
            decoration: const BoxDecoration(
              color: Color(0xFF0F110C),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8)
              )
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: [
                  Text(
                    widget.car.isAvailable ? "Currently available" : "Currently not available",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.star_border, color: Colors.white, size: 36),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
