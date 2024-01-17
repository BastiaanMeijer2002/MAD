import 'package:clucknrides/screens/home_screen/main.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final void Function(CarFilterOption, dynamic value) onFilterSelected;
  final Map<CarFilterOption, dynamic> carFilterList;

  const FilterWidget({Key? key, required this.onPressed, required this.onFilterSelected, required this.carFilterList}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();

}

class _FilterWidgetState extends State<FilterWidget> {
  bool showList = false;
  late double seatingSliderValue;
  late double engineSliderValue;
  late double priceSliderValue;
  late bool availabiltyValue;

  @override
  void initState() {
    super.initState();
    seatingSliderValue = widget.carFilterList[CarFilterOption.seating].toDouble() ?? 1.0;
    engineSliderValue = widget.carFilterList[CarFilterOption.engine].toDouble() ?? 1.0;
    priceSliderValue = widget.carFilterList[CarFilterOption.price].toDouble() ?? 1.0;
    availabiltyValue = widget.carFilterList[CarFilterOption.available] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        AnimatedContainer(
          margin: EdgeInsets.only(left: 6, top: screenHeight * 0.032, right: 0, bottom: 0),
          duration: const Duration(milliseconds: 100),
          height: showList ? MediaQuery.of(context).size.height * 0.40 : MediaQuery.of(context).size.height * 0.05,
          width: showList ? MediaQuery.of(context).size.width * 0.87 : MediaQuery.of(context).size.width * 0.41,
          child: GestureDetector(
            onTap: () {
              setState(() {
                showList = !showList;
              });
              widget.onPressed();
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFAD4D8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: showList ? null : const Row(
                children: [
                  Icon(Icons.filter_list),
                  SizedBox(width: 15.0),
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            ),
          ),
        ),
        if (showList)
          Positioned(
            top: 50.0,
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              margin: const EdgeInsets.only(left: 27, top: 30, right: 0, bottom: 0),
              decoration: BoxDecoration(
                color: const Color(0xFFFAD4D8),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView(
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        const Text(
                          "Seats",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Slider(
                          value: seatingSliderValue,
                          min: 1.0,
                          max: 10.0,
                          divisions: 10,
                          label: seatingSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              seatingSliderValue = value;
                              widget.onFilterSelected(CarFilterOption.seating, value);
                            });
                          },
                        ),
                        Text(
                          seatingSliderValue.round().toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          )
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Text(
                          "Engine",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Slider(
                          value: engineSliderValue,
                          min: 1.0,
                          max: 10.0,
                          divisions: 10,
                          label: engineSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              engineSliderValue = value;
                              widget.onFilterSelected(CarFilterOption.engine, value);
                            });
                          },
                        ),
                        Text(
                            engineSliderValue.round().toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            )
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Text(
                          "Price",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Slider(
                          value: priceSliderValue,
                          min: 0.0,
                          max: 200.0,
                          divisions: 10,
                          label: priceSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              priceSliderValue = value;
                              widget.onFilterSelected(CarFilterOption.price, value);
                            });
                          },
                        ),
                        Text(
                          priceSliderValue.round().toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          )
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: [
                        const Text(
                          "Only available cars",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        Checkbox(
                          value: availabiltyValue,
                          onChanged: (bool? value) {
                            availabiltyValue = value!;
                            widget.onFilterSelected(CarFilterOption.available, value);
                          }
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                        child: FilledButton(
                          onPressed: () {
                            setState(() {
                              showList = !showList;
                            });
                            widget.onPressed();
                          },
                          child: const Text('Filter'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}