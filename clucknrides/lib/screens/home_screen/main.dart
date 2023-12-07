import 'package:clucknrides/screens/home_screen/filter_widget/main.dart';
import 'package:clucknrides/screens/home_screen/list_item/main.dart';
import 'package:clucknrides/screens/home_screen/sort_widget/main.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  bool isFilterSelected = false;
  bool isSortSelected = false;

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
            fontWeight: FontWeight.w600
          )
        )
      ),
      body: Stack(
        children: [
          const Positioned(
            top: 125,
            left: 0,
            right: 0,
            child: ListItem(true),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isFilterSelected || isSortSelected ? 0.5 : 0.0,
            child: const ModalBarrier(
              color: Color(0xFF0F110C),
              dismissible: false,
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