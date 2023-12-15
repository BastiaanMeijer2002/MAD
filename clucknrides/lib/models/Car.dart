class Car {
  String name;
  int capacity;
  String fuel;
  double rate;
  String img;

  Car({
    required this.name,
    required this.capacity,
    required this.fuel,
    required this.img,
    required this.rate,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: '${json["brand"]} ${json["model"]}' ?? '',
      capacity: json["nrOfSeats"] ?? 0,
      fuel: json["fuel"] ?? 'fuel',
      img: 'fiesta.png',
      rate: json["price"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'capacity': capacity,
      'range': fuel,
      'img': img,
      'rate': rate,
    };
  }
}
