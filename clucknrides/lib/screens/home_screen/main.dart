import 'package:clucknrides/models/Car.dart';
import 'package:clucknrides/screens/home_screen/filter_widget/main.dart';
import 'package:clucknrides/screens/home_screen/list_item/main.dart';
import 'package:clucknrides/screens/home_screen/sort_widget/main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isFilterSelected = false;
  bool isSortSelected = false;

  List<Car> cars = [
    Car(name: "Ford Fiesta", capacity: 4, range: 200, isAvailable: true, img: 'fiesta.png'),
    Car(name: "Ford Fiesta", capacity: 4, range: 200, isAvailable: false, img: 'fiesta.png'),
    Car(name: "Ford Fresta", capacity: 4, range: 200, isAvailable: false, img: 'fiesta.png'),
    Car(name: "Ford Fresta", capacity: 4, range: 200, isAvailable: true, img: 'fiesta.png'),
    Car(name: "Ford Fresta", capacity: 4, range: 200, isAvailable: false, img: 'fiesta.png'),
    Car(name: "Ford Fresta", capacity: 4, range: 200, isAvailable: true, img: 'fiesta.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body:
      Stack(
        children: [
          Positioned.fill(
            top: 110,
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),

                itemCount: cars.length,
                itemBuilder: (context, index) {
                  return ListItem(
                    cars[index].isAvailable,
                    cars[index].name,
                    cars[index].capacity,
                    cars[index].range,
                    cars[index].img,
                  );
                },
              ),
            ),
          ),
          if (isFilterSelected || isSortSelected)
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isFilterSelected || isSortSelected ? 0.5 : 0.0,
              child: const Positioned.fill(
                child: ModalBarrier(
                  color: Color(0xFF0F110C),
                  dismissible: false,
                ),
              ),
            ),
          Positioned(
            top: 10,
            left: 2,
            child: SortWidget(
              onPressed: () {
                setState(() {
                  isSortSelected = !isSortSelected;
                });
              },
            ),
          ),
          Positioned(
            top: 10,
            right: 28,
            child: FilterWidget(
              onPressed: () {
                setState(() {
                  isFilterSelected = !isFilterSelected;
                });
              },
            ),
          ),
        ],
      )

    );
  }
}
