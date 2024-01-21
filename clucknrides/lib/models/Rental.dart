import 'package:clucknrides/models/Customer.dart';

import 'Car.dart';

class Rental {
  int id;
  String code;
  double longitude;
  double latitude;
  String fromDate;
  String toDate;
  String state;
  Car car;
  Customer customer;

  Rental({
    required this.id,
    required this.code,
    required this.longitude,
    required this.latitude,
    required this.fromDate,
    required this.toDate,
    required this.state,
    required this.car,
    required this.customer,
  });

  factory Rental.fromJson(Map<String, dynamic> json) {
    return Rental(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      longitude: json['longitude'] ?? 0.0,
      latitude: json['latitude'] ?? 0.0,
      fromDate: json['fromDate'] ?? '',
      toDate: json['toDate'] ?? '',
      state: json['state'] ?? '',
      car: Car.fromJson(json['car'] ?? {}),
      customer: Customer.fromJson(json["customer"] ?? {}),
    );
  }

  factory Rental.fromJsonWithRelated(Map<String, dynamic> json, {Car? car, Customer? customer}) {
    return Rental(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      longitude: json['longitude'] ?? 0.0,
      latitude: json['latitude'] ?? 0.0,
      fromDate: json['fromDate'] ?? '',
      toDate: json['toDate'] ?? '',
      state: json['state'] ?? '',
      car: car ?? Car.fromJson(json['car'] ?? {}),
      customer: customer ?? Customer.fromJson(json['customer'] ?? {}),
    );
  }

  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'code': code,
      'longitude': longitude,
      'latitude': latitude,
      'fromDate': fromDate,
      'toDate': toDate,
      'state': state,
      'carId': car.id,
      'customerId': customer.id,
    };
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'longitude': longitude,
      'latitude': latitude,
      'fromDate': fromDate,
      'toDate': toDate,
      'state': state,
      'car': car,
      'customerId': customer,
    };
  }

}
