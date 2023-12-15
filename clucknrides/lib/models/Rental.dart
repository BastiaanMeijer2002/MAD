import 'Car.dart';

class Rental {
  String code;
  double longitude;
  double latitude;
  String fromDate;
  String toDate;
  String state;
  Car car;

  Rental({
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.fromDate,
    required this.toDate,
    required this.state,
    required this.car,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      code: json['code'] ?? '',
      longitude: json['longitude'] ?? 0.0,
      latitude: json['latitude'] ?? 0.0,
      fromDate: json['fromDate'] ?? '',
      toDate: json['toDate'] ?? '',
      state: json['state'] ?? '',
      car: Car.fromJson(json['car'] ?? {}),
    );
  }
}