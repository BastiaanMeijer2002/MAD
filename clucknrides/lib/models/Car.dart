class Car {
  String name;
  int capacity;
  double range;
  bool isAvailable;
  String img;

  Car({
    required this.name,
    required this.capacity,
    required this.range,
    required this.isAvailable,
    required this.img,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      name: json["name"] ?? '',
      capacity: json["capacity"] ?? 0,
      range: json["range"] ?? 0,
      isAvailable: json["isAvailable"] ?? 0,
      img: json["img"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'capacity': capacity,
      'range': range,
      'isAvailable': isAvailable,
      'img': img,
    };
  }
}
