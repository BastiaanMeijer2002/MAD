import 'package:clucknrides/repositories/inspectionRepository.dart';
import 'package:clucknrides/screens/profile_screen/main.dart';
import 'package:clucknrides/services/fetch_inspections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clucknrides/models/Car.dart';
import 'package:clucknrides/repositories/rentalRepository.dart';
import 'package:clucknrides/repositories/customerRepository.dart';
import 'package:clucknrides/repositories/carRepository.dart';
import 'package:clucknrides/screens/home_screen/filter_widget/main.dart';
import 'package:clucknrides/screens/home_screen/list_item/main.dart';
import 'package:clucknrides/screens/home_screen/sort_widget/main.dart';
import 'package:clucknrides/services/fetch_cars.dart';
import 'package:clucknrides/services/fetch_rentals.dart';
import 'package:clucknrides/services/reverse_geocode.dart';
import 'package:clucknrides/services/fetch_customers.dart';
import 'package:clucknrides/services/is_available.dart';
import 'package:clucknrides/widgets/loading_widget/main.dart';

import '../../models/Rental.dart';

enum CarSortOption {
  lowestPrice,
  highestSeating,
  closest,
  highestEngine,
  newest,
}

enum CarFilterOption {
  available,
  seating,
  engine,
  price,
  all,
}

class HomeScreen extends StatefulWidget {
  final FlutterSecureStorage storage;
  final RentalRepository rentals;
  final CustomerRepository customers;
  final InspectionRepository inspections;
  final CarRepository cars;

  const HomeScreen({
    Key? key,
    required this.storage,
    required this.rentals,
    required this.customers,
    required this.cars,
    required this.inspections,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  late Future<List<Car>> futureCars;
  late List<Rental> rentals;
  bool isFilterSelected = false;
  bool isSortSelected = false;
  CarSortOption currentSortOption = CarSortOption.closest;
  CarFilterOption currentFilterOption = CarFilterOption.all;
  Map<CarFilterOption, dynamic> carFilterOptions = {
    CarFilterOption.available: false,
    CarFilterOption.seating: 5,
    CarFilterOption.engine: 2,
    CarFilterOption.price: 100,
  };
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _refreshCars();
    _getLocation();
    fetchRentals(widget.storage, widget.rentals);
    fetchCustomers(widget.storage, widget.customers);
  }

  List<Car> _getSortedCarList(List<Car> carList) {
    switch (currentSortOption) {
      case CarSortOption.closest:
        if (_currentPosition == null) {
          return carList;
        }

        carList.sort((a, b) {
          double distanceToA = Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            a.latitude,
            a.longitude,
          );

          double distanceToB = Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            b.latitude,
            b.longitude,
          );

          return distanceToA.compareTo(distanceToB);
        });

        return carList;
      case CarSortOption.lowestPrice:
        carList.sort((a, b) => a.price.compareTo(b.price));
        return carList;
      case CarSortOption.highestSeating:
        carList.sort((a, b) => b.nrOfSeats.compareTo(a.nrOfSeats));
        return carList;
      case CarSortOption.highestEngine:
        carList.sort((a, b) => b.engineSize.compareTo(a.engineSize));
        return carList;
      case CarSortOption.newest:
        carList.sort((a, b) => b.modelYear.compareTo(a.modelYear));
        return carList;
    }
  }

  List<Car> _getFilteredCarList(List<Car> carlist) {
    bool filterByAvailable = carFilterOptions[CarFilterOption.available] ?? false;
    double filterBySeating = (carFilterOptions[CarFilterOption.seating] ?? 0).toDouble();
    double filterByEngine = (carFilterOptions[CarFilterOption.engine] ?? 0).toDouble();
    double filterByPrice = (carFilterOptions[CarFilterOption.price] ?? 0).toDouble();

    return carlist.where((car) {
      if (filterByPrice > 0 && car.price > filterByPrice) {
        return false;
      }

      if (filterByEngine > 0 && car.engineSize < filterByEngine) {
        return false;
      }

      if (filterBySeating > 0 && car.nrOfSeats < filterBySeating) {
        return false;
      }

      return true;
    }).toList();
  }

  Future<void> _refreshCars() async {
    setState(() {
      futureCars = fetchCars(widget.storage, widget.cars);
      fetchRentals(widget.storage, widget.rentals);
    });
  }

  Future<void> _onRefresh() async {
    await _refreshCars();
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff0f110c),
        title: const Text(
          "Cluck'N'Rides",
          style: TextStyle(
            color: Color(0xfffcf7f7),
            fontFamily: "Inter",
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await fetchInspections(widget.storage, widget.inspections);
              if (context.mounted) Navigator.of(context).pushNamed('profile');
            },
            icon: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 36,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Stack(
          children: [
            Positioned(
              top: screenHeight * 0.162,
              left: 0,
              right: 0,
              bottom: 0,
              child: FutureBuilder<List<Car>>(
                future: futureCars,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Car> carlist = _getSortedCarList(snapshot.data as List<Car>);
                    carlist = _getFilteredCarList(carlist);

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: carlist.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: isAvailable(widget.storage, widget.rentals, carlist[index]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (carFilterOptions[CarFilterOption.available] && !snapshot.data!) {
                                return Container();
                              }
                              return ListItem(
                                carlist[index],
                                snapshot.data as bool,
                                location: _currentPosition,
                                rentals: widget.rentals,
                                customers: widget.customers,
                                storage: widget.storage,
                                inspections: widget.inspections,
                              );
                            }
                            return const Text("test");
                          },
                        );
                      },
                    );
                  }
                  return const LoadingWidget(message: "Loading the chickens...");
                },
              ),
            ),
            if (isFilterSelected || isSortSelected)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSortSelected = !isSortSelected;
                  });
                },
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 100),
                  opacity: isFilterSelected || isSortSelected ? 0.5 : 0.0,
                  child: const Positioned.fill(
                    child: ModalBarrier(
                      color: Color(0xFF0F110C),
                      dismissible: false,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: screenHeight * 0.059,
              left: screenWidth * 0.01,
              child: SortWidget(
                onSortSelected: (sortOption) {
                  setState(() {
                    currentSortOption = sortOption;
                  });
                },
                onPressed: () {
                  setState(() {
                    isSortSelected = !isSortSelected;
                  });
                },
                currentOption: currentSortOption,
              ),
            ),
            Positioned(
              top: screenHeight * 0.059,
              right: screenWidth * 0.07,
              child: FilterWidget(
                onPressed: () {
                  setState(() {
                    isFilterSelected = !isFilterSelected;
                  });
                },
                onFilterSelected: (filterOption, value) {
                  setState(() {
                    carFilterOptions[filterOption] = value;
                  });
                },
                carFilterList: carFilterOptions,
              ),
            ),
            Positioned(
              top: screenHeight * 0.03,
              left: screenWidth * 0.07,
              right: screenWidth * 0.06,
              child: Container(
                width: screenWidth * 0.85,
                height: screenHeight * 0.054,
                decoration: const BoxDecoration(
                  color: Color(0XFFFAD4D8),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(Icons.near_me),
                      const SizedBox(width: 15.0),
                      FutureBuilder(
                        future: reverseGeocode(_currentPosition?.longitude ?? 0.0, _currentPosition?.latitude ?? 0.0),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data ?? "No location found",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });

      Geolocator.getPositionStream().listen((Position position) {
        setState(() {
          _currentPosition = position;
        });
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}
