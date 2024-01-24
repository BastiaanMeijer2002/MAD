import 'dart:convert';

import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:clucknrides/services/fetch_customer.dart';
import 'package:clucknrides/services/fetch_rentals.dart';
import 'package:clucknrides/services/startRent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/Car.dart';
import '../../../models/Customer.dart';
import '../../../models/Rental.dart';
import '../../../services/stopRental.dart';

class RentWidget extends StatefulWidget {
  final FlutterSecureStorage storage;
  final Car car;
  final CustomerRepository customers;
  final RentalRepository rentals;
  final InspectionRepository inspections;
  final bool available;

  const RentWidget({Key? key, required this.car, required this.customers, required this.storage, required this.rentals, required this.available, required this.inspections}) : super(key: key);

  @override
  State<RentWidget> createState() => _RentWidgetState();
}

class _RentWidgetState extends State<RentWidget> {
  DateTime? selectedDate;
  late bool isActive;
  bool active = false;
  late Rental activeRental;
  String file = '';
  String imgState = "No image selected";
  String damageDescription = '';
  @override
  void initState() {
    super.initState();
    getActive();
  }

  Future<void> getActive() async {
    Customer currentCustomer = await fetchCustomer(widget.storage, widget.customers);
    isActive = await widget.rentals.isActiveRent(widget.car, currentCustomer);
    activeRental = await widget.rentals.activeRental(widget.car);
    if (isActive) {
      activeRent(context);
      active = true;
    }
  }

  Future<void> getModal() async {
    Customer currentCustomer = await fetchCustomer(widget.storage, widget.customers);
    isActive = await widget.rentals.isActiveRent(widget.car, currentCustomer);
    if (isActive) {
      activeRent(context);
    } else {
      newRent(context);
    }
  }

  Future<void> _uploadPhoto() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choose Source"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.gallery);
                  setState(() {
                    imgState = "Image selected";
                  });
                },
                child: const Text("Gallery"),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.camera);
                  setState(() {
                    imgState = "Image selected";
                  });
                },
                child: const Text("Camera"),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile.readAsBytes();
      setState(() {
        file = base64Encode(imageBytes);
        imgState = "Image selected";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (!widget.available && !active) {
      return Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.032, left: screenWidth * 0.035, right: screenWidth * 0.035),
        child: SizedBox(
          width: screenWidth * 0.444,
          height: screenHeight * 0.043,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight * 0.032, left: screenWidth * 0.035, right: screenWidth * 0.035),
      child: GestureDetector(
        onTap: () async {
          await getModal();
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFAD4D8),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          width: screenWidth * 0.444,
          height: screenHeight * 0.043,
          child: Center(
            child: Text(
              active ? "End rental" : "Rent now",
              style: TextStyle(
                fontSize: screenWidth * 0.056,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void newRent(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.22,
          decoration: const BoxDecoration(
            color: Color(0XFFFAD4D8),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Rent this car',
                        style: TextStyle(
                          fontFamily: "inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "inter",
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0XFF0F110C)),
                              foregroundColor: MaterialStateProperty.all(const Color(0XFFFFFCFC)),
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "inter",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFFFFFCFC),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              await startRent(widget.storage, widget.car, widget.customers, widget.rentals);
                              Navigator.pop(context);
                              getActive();
                              setState(() {
                                active = true;
                              });
                            },
                            child: const Text(
                              'Start renting',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "inter",
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void activeRent(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.22,
          decoration: const BoxDecoration(
            color: Color(0XFFFAD4D8),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Currently renting',
                        style: TextStyle(
                          fontFamily: "inter",
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'You have been renting since ${activeRental.fromDate}',
                        style: const TextStyle(
                          fontFamily: "inter",
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        maxLines: 3,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(const Color(0XFF0F110C)),
                              foregroundColor: MaterialStateProperty.all(const Color(0XFFFFFCFC)),
                              textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                  fontSize: 18,
                                  fontFamily: "inter",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFFFFFCFC),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              fetchRentals(widget.storage, widget.rentals);
                              Navigator.pop(context);
                              inspectionModel(context);
                            },
                            child: const Text(
                              'Stop renting',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "inter",
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void inspectionModel(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 1.5,
          decoration: const BoxDecoration(
            color: Color(0XFFFAD4D8),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Header
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Howdy, thanks for using Cluck'N'Rides",
                    style: TextStyle(
                      fontFamily: "inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),

              // Description
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Please check the vehicle for any damages. If you do spot any, please submit a picture of the damages and give an additional description. ',
                    style: TextStyle(
                      fontFamily: "inter",
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                    maxLines: 4,
                  ),
                ),
              ),

              // Upload photo button
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0XFF0F110C)),
                          foregroundColor: MaterialStateProperty.all(const Color(0XFFFFFCFC)),
                        ),
                        onPressed: () async {
                          await _uploadPhoto();
                        },
                        child: const Text('Upload photo'),
                      ),
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        return Text(imgState);
                      },
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        damageDescription = value;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Describe the damage shown in the picture',
                    ),
                  ),
                ),
              ),
              // Buttons and actions
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0XFF0F110C)),
                            foregroundColor: MaterialStateProperty.all(const Color(0XFFFFFCFC)),
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(
                                fontSize: 18,
                                fontFamily: "inter",
                                fontWeight: FontWeight.w600,
                                color: Color(0XFFFFFCFC),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            fetchRentals(widget.storage, widget.rentals);
                            await stopRent(
                              widget.storage,
                              widget.car,
                              widget.customers,
                              widget.rentals,
                              widget.inspections,
                              file,
                              damageDescription,
                            );
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Stop renting',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "inter",
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

