import 'Rental.dart';

class Inspection {
  int id;
  String photo;
  String code;
  int odometer;
  String photoContentType;
  String completed;
  String result;
  int rentalId;

  Inspection(
      {required this.id,
      required this.photo,
      required this.code,
      required this.odometer,
      required this.photoContentType,
      required this.completed,
      required this.result,
      required this.rentalId
      });

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return Inspection(
        id: json["id"] ?? 0,
        photo: json["photo"] ?? '',
        code: json["code"] ?? '',
        odometer: json["odometer"] ?? 0,
        photoContentType: json["photoContentType"] ?? '',
        completed: json["completed"] ?? '',
        result: json['result'] ?? '',
        rentalId: json["rental"] != null ? json["rental"]["id"] : json["rentalId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo': photo,
      'code': code,
      'odometer': odometer,
      'photoContentType': photoContentType,
      'completed': completed,
      'result': result,
      'rentalId': rentalId,
    };
  }
}
