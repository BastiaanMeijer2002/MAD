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
            color: widget.isAvailable ? const Color(0xFFFAD4D8) : const Color(0xFF9BBFB9),
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
                    widget.isAvailable ? "Currently available" : "Currently not available",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    child: Icon(favorite ? Icons.star : Icons.star_border, color: Colors.white, size: 36),
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
            padding: const EdgeInsets.only(top: 26, right: 20, left: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF0F110C),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              width: double.infinity,
              height: 220,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  top: 17
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/people.svg',
                          width: 55,
                          height: 55,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 105),
                          child: Text(
                            "${widget.car.capacity} persons",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 13,
                        bottom: 13,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/fuel.svg',
                            width: 55,
                            height: 55,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 105),
                            child: Text(
                              "${widget.car.fuel} KM",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
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
                          width: 55,
                          height: 55,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 105),
                          child: Text(
                            "€${widget.car.rate}/KM",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
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
                padding: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFAD4D8),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      width: 190,
                      height: 40,
                      child: const Center(
                        child: Text(
                          "Rent now",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, right: 15),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF9BBFB9),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      width: 190,
                      height: 40,
                      child: const Center(
                        child: Text(
                          "Book for later",
                          style: TextStyle(
                              fontSize: 24,
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
      )
    );
  }
}
