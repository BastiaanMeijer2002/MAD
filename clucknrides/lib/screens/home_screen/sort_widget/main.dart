import 'package:flutter/material.dart';
import 'package:clucknrides/screens/home_screen/sort_widget/main.dart';

import '../main.dart';

class SortWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final void Function(CarSortOption) onSortSelected;
  final CarSortOption currentOption;

  const SortWidget({
    Key? key,
    required this.onPressed,
    required this.onSortSelected,
    required this.currentOption,
  }) : super(key: key);

  @override
  State<SortWidget> createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(
            left: screenWidth * 0.063, // 27 / 926
            top: screenHeight * 0.032, // 30 / 926
            right: 0,
            bottom: 0,
          ),
          duration: const Duration(milliseconds: 100),
          height: showList ? screenHeight * 0.4105 : screenHeight * 0.05, // 0.38 : 0.05
          child: GestureDetector(
            onTap: () {
              setState(() {
                showList = !showList;
              });
              widget.onPressed();
            },
            child: Container(
              width: screenWidth * 0.409, // 175 / 926
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFAD4D8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.sort),
                  SizedBox(width: 15.0),
                  Text(
                    'Sort',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showList)
          Positioned(
            top: screenHeight * 0.054 + screenHeight * 0.032, // 0.054 : 0.032
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              margin: EdgeInsets.only(
                left: screenWidth * 0.063, // 27 / 926
                top: screenHeight * 0.032, // 30 / 926
                right: 0,
                bottom: 0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFAD4D8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView(
                children: [
                  buildListTile("Closest", CarSortOption.closest),
                  buildListTile("Lowest price", CarSortOption.lowestPrice),
                  buildListTile("Most seats", CarSortOption.highestSeating),
                  buildListTile("Highest engine size", CarSortOption.highestEngine),
                  buildListTile("Newest", CarSortOption.newest),
                ],
              ),
            ),
          ),
      ],
    );
  }

  ListTile buildListTile(String title, CarSortOption option) {
    bool isSelected = option == widget.currentOption;
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () {
        widget.onSortSelected(option);
        setState(() {
          showList = false;
          widget.onPressed();
        });
      },
    );
  }
}
