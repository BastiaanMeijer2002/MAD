import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const FilterWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();

}

class _FilterWidgetState extends State<FilterWidget> {
  bool showList = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          AnimatedContainer(
            margin: const EdgeInsets.only(left: 16, top: 30, right: 0, bottom: 0),
            duration: const Duration(milliseconds: 100),
            height: showList ? 250.0 : 50.0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showList = !showList;
                });
                widget.onPressed();
              },
              child: Container(
                width: 175,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAD4D8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
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
                child: null
              ),
            ),
        ],
      );
  }
}