class Car {
  String name;
  int capacity;
  double range;
  double rate;
  bool isAvailable;
  String img;

  Car({
    required this.name,
    required this.capacity,
    required this.range,
    required this.isAvailable,
    required this.img,
    required this.rate,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: json["name"] ?? '',
      capacity: json["capacity"] ?? 0,
      range: json["range"] ?? 0,
      isAvailable: json["isAvailable"] ?? 0,
      img: json["img"],
      rate: json["rate"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'capacity': capacity,
      'range': range,
      'isAvailable': isAvailable,
      'img': img,
      'rate': rate,
    };
  }
}
