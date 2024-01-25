import 'package:clucknrides/models/Car.dart';

class CarScreenArguments {
  final Car car;
  final bool isFavorite;
  final bool isAvailable;

  CarScreenArguments({required this.car, required this.isFavorite, required this.isAvailable});
}