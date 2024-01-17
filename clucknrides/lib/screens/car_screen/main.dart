import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/Car.dart';

class CarScreen extends StatefulWidget {
  final Car car;
  final bool isFavorite;
  final bool isAvailable;

  const CarScreen({Key? key, required this.car, required this.isFavorite, required this.isAvailable}) : super(key: key);

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height; // Update with the actual screen height
    double screenWidth = MediaQuery.of(context).size.width; // Update with the actual screen width

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
            height: screenHeight * 0.307, // 286 / 926
            color: widget.isAvailable ? const Color(0xFFFAD4D8) : const Color(0xFF9BBFB9),
            child: Center(child: Image.asset('assets/images/${widget.car.img}')),
          ),
          Container(
            width: double.infinity,
            height: screenHeight * 0.061, // 56 / 926
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
                    widget.isAvailable ? "Currently available" : "Currently not available",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Icon(favorite ? Icons.star : Icons.star_border, color: Colors.white, size: screenWidth * 0.084), // 36 / 428
                    onTap: (){
                      setState(() {
                        favorite = !favorite;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.028, right: 20, left: 20), // 26 / 926
            child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF0F110C),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                width: double.infinity,
                height: screenHeight * 0.238, // 220 / 926
                child: Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth * 0.117, // 50 / 428
                      top: screenHeight * 0.018 // 17 / 926
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/people.svg',
                            width: screenWidth * 0.128, // 55 / 428
                            height: screenHeight * 0.059, // 55 / 926
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.246), // 105 / 428
                            child: Text(
                              "${widget.car.capacity} persons",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.056, // 24 / 428
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.014, // 13 / 926
                          bottom: screenHeight * 0.014, // 13 / 926
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/fuel.svg',
                              width: screenWidth * 0.128, // 55 / 428
                              height: screenHeight * 0.059, // 55 / 926
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: screenWidth * 0.246), // 105 / 428
                              child: Text(
                                widget.car.fuel.toLowerCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.056, // 24 / 428
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/price.svg',
                            width: screenWidth * 0.128, // 55 / 428
                            height: screenHeight * 0.059, // 55 / 926
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: screenWidth * 0.246), // 105 / 428
                            child: Text(
                              "€${widget.car.rate}/KM",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.056, // 24 / 428
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.5
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.032, left: screenWidth * 0.035, right: screenWidth * 0.035), // 30 / 926, 15 / 428
                child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFAD4D8),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        width: screenWidth * 0.444, // 190 / 428
                        height: screenHeight * 0.043, // 40 / 926
                        child: Center(
                          child: Text(
                            "Rent now",
                            style: TextStyle(
                                fontSize: screenWidth * 0.056, // 24 / 428
                                fontWeight: FontWeight.w600
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.032, right: screenWidth * 0.035), // 30 / 926, 15 / 428
                child: Row(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF9BBFB9),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        width: screenWidth * 0.444, // 190 / 428
                        height: screenHeight * 0.043, // 40 / 926
                        child: Center(
                          child: Text(
                            "Book for later",
                            style: TextStyle(
                                fontSize: screenWidth * 0.056, // 24 / 428
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
