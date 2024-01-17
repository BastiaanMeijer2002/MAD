import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


// Future<void> getLocation() async {
//   try {
//     LocationPermission permission = await Geolocator.checkPermission();
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
//         // Handle case where user denies permission
//         return;
//       }
//     }
//
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     setState(() {
//       _currentPosition = position;
//     });
//   } catch (e) {
//     print('Error getting location: $e');
//   }
// }
