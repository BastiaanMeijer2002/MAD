import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final bool isAvailable;

  const ListItem(this.isAvailable, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
        decoration: BoxDecoration(
          color: isAvailable ? const Color(0xFFFAD4D8) : const Color(0xFF9BBFB9),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF0F110C),
            width: 1.0
          )
        ),
        margin: const EdgeInsets.only(left: 27, top: 0, bottom: 23, right: 0),
        width: 373,
        height: 242,
        child: const Text("test"),
      )
    ]
    );
  }
}