import 'dart:convert';

class Customer {
  int id;
  int nr;
  String lastName;
  String firstName;
  String from;

  Customer({
    required this.id,
    required this.nr,
    required this.lastName,
    required this.firstName,
    required this.from,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json["id"] ?? 0,
        nr: json["nr"] ?? 0,
        lastName: json["lastName"] ?? "",
        firstName: json["firstName"] ?? "",
        from: json["from"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': nr,
      'lastName': lastName,
      'firstName': firstName,
      'from': from,
    };
  }

  String serialize() => json.encode(this);

  static Customer deserialize(String json) => jsonDecode(json);

}