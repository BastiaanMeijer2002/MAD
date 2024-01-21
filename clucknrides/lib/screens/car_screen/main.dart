import 'package:clucknrides/screens/car_screen/rent_widget/main.dart';
import 'package:clucknrides/services/reverse_geocode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../../models/Car.dart';
import '../../repositories/customerRepository.dart';
import '../../repositories/rentalRepository.dart';

class CarScreen extends StatefulWidget {
  final Car car;
  final bool isFavorite;
  final bool isAvailable;
  final RentalRepository rentals;
  final CustomerRepository customers;
  final FlutterSecureStorage storage;

  const CarScreen({Key? key, required this.car, required this.isFavorite, required this.isAvailable, required this.rentals, required this.customers, required this.storage}) : super(key: key);

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  bool favorite = false;

  @override
  void initState()  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0f110c),
        title: Builder(
          builder: (BuildContext context) {
            return Text(
              "Rent ${widget.car.brand} ${widget.car.model}",
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
        mainAxisSize: MainAxisSize.min,
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
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              constraints: BoxConstraints(
                minHeight: screenHeight * 0.44
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.028, right: 20, left: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF0F110C),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight * 0.029,
                                left: screenWidth * 0.126,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/people.svg',
                                        width: screenWidth * 0.128,
                                        height: screenHeight * 0.059,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: screenWidth * 0.246),
                                        child: Text(
                                          "${widget.car.nrOfSeats} persons",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth * 0.056,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: screenHeight * 0.029),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/fuel.svg',
                                          width: screenWidth * 0.128,
                                          height: screenHeight * 0.059,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: screenWidth * 0.246),
                                          child: Text(
                                            widget.car.fuel.toLowerCase(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenWidth * 0.056,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: screenHeight * 0.029),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/year.png',
                                          width: screenWidth * 0.128,
                                          height: screenHeight * 0.059,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: screenWidth * 0.246),
                                          child: Text(
                                            "${widget.car.modelYear}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenWidth * 0.056,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: screenHeight * 0.029),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/price.svg',
                                          width: screenWidth * 0.128, // 55 / 428
                                          height: screenHeight * 0.059, // 55 / 926
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: screenWidth * 0.246), // 105 / 428
                                          child: Text(
                                            "€${widget.car.price}/KM",
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
                                  GestureDetector(
                                    onTap: () {MapsLauncher.launchCoordinates(widget.car.latitude, widget.car.longitude);},
                                    child: Padding(
                                      padding: EdgeInsets.only(top: screenHeight * 0.029),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/icons/location48.png',
                                            width: screenWidth * 0.128,
                                            height: screenHeight * 0.059,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: screenWidth * 0.246), // 105 / 428
                                            child: FutureBuilder(
                                              future: reverseGeocode(widget.car.longitude, widget.car.latitude),
                                              builder: (context, snapshot) {
                                                return Text(
                                                  snapshot.hasData ? snapshot.data!.substring(0, 11) : "No location found",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: screenWidth * 0.056, // 24 / 428
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.5
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight * 0.029,
                                      bottom: screenHeight * 0.029,
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/engine.png',
                                          width: screenWidth * 0.128,
                                          height: screenHeight * 0.059,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: screenWidth * 0.246),
                                          child: Text(
                                            "${widget.car.engineSize}.0 Litres",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenWidth * 0.056,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Row(
            children: [
              RentWidget(car: widget.car, storage: widget.storage, customers: widget.customers, rentals: widget.rentals, available: widget.isAvailable,),
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
