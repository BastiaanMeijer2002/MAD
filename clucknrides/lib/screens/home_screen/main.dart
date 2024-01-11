import 'dart:developer';

import 'package:clucknrides/main.dart';
import 'package:clucknrides/models/Car.dart';
import 'package:clucknrides/screens/home_screen/filter_widget/main.dart';
import 'package:clucknrides/screens/home_screen/list_item/main.dart';
import 'package:clucknrides/screens/home_screen/sort_widget/main.dart';
import 'package:clucknrides/services/fetch_cars.dart';
import 'package:clucknrides/services/fetch_rentals.dart';
import 'package:clucknrides/widgets/errors/server_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/Rental.dart';
import '../../services/is_available.dart';
import '../../widgets/loading_widget/main.dart';

enum CarSortOption {
  lowestPrice,
  highestSeating,
  closest,
  highestEngine,
  newest
}

class HomeScreen extends StatefulWidget {
  final FlutterSecureStorage storage;

  const HomeScreen({Key? key, required this.storage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Car>> futureCars;
  bool isFilterSelected = false;
  bool isSortSelected = false;
  CarSortOption currentSortOption = CarSortOption.closest;

  @override
  void initState() {
    super.initState();
    futureCars = fetchCars(widget.storage);
  }

  List<Car> _getSortedCarList(List<Car> carList) {
    switch (currentSortOption) {
      case CarSortOption.closest:
        return carList;
      case CarSortOption.lowestPrice:
        carList.sort((a, b) => a.rate.compareTo(b.rate));
        return carList;
      case CarSortOption.highestSeating:
        carList.sort((a, b) => b.capacity.compareTo(a.capacity));
        return carList;
      case CarSortOption.highestEngine:
        carList.sort((a, b) => b.engineSize.compareTo(a.engineSize));
        return carList;
      case CarSortOption.newest:
        carList.sort((a, b) => b.modelYear.compareTo(a.modelYear));
        return carList;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      ),
      body: Stack(
        children: [
          Positioned(
            top: 150,
            left: 0,
            right: 0,
            bottom: 0,
            child: FutureBuilder<List<Car>>(
              future: futureCars,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Car> carlist = _getSortedCarList(snapshot.data as List<Car>);
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: carlist.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: isAvailable(widget.storage, carlist[index]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData){
                            return ListItem(carlist[index], snapshot.data as bool);
                          }
                          return Container();
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
              child:
              AnimatedOpacity(
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
            top: 55,
            left: MediaQuery.of(context).size.width * 0.01,
            child: SortWidget(
              onSortSelected: (sortOption) {
                setState(() {
                  currentSortOption = sortOption;
                });
              }, onPressed: () {
                  setState(() {
                    isSortSelected = !isSortSelected;
                  }
                );
              },
              currentOption: currentSortOption,
            ),
          ),
          Positioned(
            top: 55,
            right: MediaQuery.of(context).size.width * 0.07,
            child: FilterWidget(
              onPressed: () {
                setState(() {
                  isFilterSelected = !isFilterSelected;
                });
              },
            ),
          ),
          Positioned(
            top: 28,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.06,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: const BoxDecoration(
                color: Color(0XFFFAD4D8),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
