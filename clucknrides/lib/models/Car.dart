class Car {
  int id;
  String brand;
  String model;
  int nrOfSeats;
  String fuel;
  double price;
  int engineSize;
  int modelYear;
  String img;
  double longitude;
  double latitude;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.nrOfSeats,
    required this.fuel,
    required this.img,
    required this.price,
    required this.engineSize,
    required this.modelYear,
    required this.longitude,
    required this.latitude,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json["id"] ?? 0,
      brand: json["brand"] ?? '',
      model: json["model"] ?? '',
      nrOfSeats: json["nrOfSeats"] ?? 0,
      fuel: json["fuel"] ?? 'fuel',
      img: 'fiesta.png',
      price: (json["price"] ?? 0.0).toDouble(),
      engineSize: json["engineSize"] ?? 0,
      modelYear: json["modelYear"] ?? 0,
      longitude: json["longitude"] ?? 0.0,
      latitude: json["latitude"] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'nrOfSeats': nrOfSeats,
      'fuel': fuel,
      'img': img,
      'price': price,
      'engineSize': engineSize,
      'modelYear': modelYear,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
