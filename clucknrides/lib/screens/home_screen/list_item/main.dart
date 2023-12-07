import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ListItem extends StatelessWidget {
  final bool isAvailable;
  final String carName;
  final int capacity;
  final double range;
  final String img;

  const ListItem(this.isAvailable, this.carName, this.capacity, this.range, this.img, {super.key});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 105,
              height: 30,
              decoration: const BoxDecoration(
                color: Color(0xFF0F110C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(8)
                )
              ),
              child: Center(
                child: Text(
                  isAvailable ? "Available" : "Not available",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFF1ECEC)
                  ),
                ),
              )
            ),
            Center(
              child: Image.asset(
                'assets/images/$img',
                width: 500,
                height: 154,
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 56,
              decoration: const BoxDecoration (
                color: Color(0xFF0F110C),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8)
                )
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 17),
                    child: Text(
                      carName,
                      style: const TextStyle(
                        color: Color(0xFFF1ECEC),
                        fontWeight: FontWeight.w600,
                        fontSize: 16
                      )
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 9),
                    child:                   Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/people.svg',
                          width: 24,
                          height: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 7),
                          child: Text(
                            '$capacity',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFF1ECEC)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/fuel.svg',
                                width: 24,
                                height: 24,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: Text(
                                  '$range',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFFF1ECEC)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                    ,
                  )
                ],
              ),
            )
          ],
        ),
      )
    ]
    );
  }
}