class Car {
  String name;
  int capacity;
  String fuel;
  double rate;
  int engineSize;
  int modelYear;
  String img;

  Car({
    required this.name,
    required this.capacity,
    required this.fuel,
    required this.img,
    required this.rate,
    required this.engineSize,
    required this.modelYear,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: '${json["brand"]} ${json["model"]}' ?? '',
      capacity: json["nrOfSeats"] ?? 0,
      fuel: json["fuel"] ?? 'fuel',
      img: 'fiesta.png',
      rate: (json["price"] ?? 0.0).toDouble(),
      engineSize: json["engineSize"] ?? 0,
      modelYear: json["modelYear"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'capacity': capacity,
      'range': fuel,
      'img': img,
      'rate': rate,
      'engineSize': engineSize,
      'modelYear': modelYear,
    };
  }
}
