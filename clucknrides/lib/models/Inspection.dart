class Inspection {
  int id;
  String photo;
  String code;
  int odometer;
  String photoContentType;
  String completed;
  String result;

  Inspection({required this.id, required this.photo, required this.code, required this.odometer, required this.photoContentType, required this.completed, required this.result});

  factory Inspection.fromJson(Map<String, dynamic> json) {
    return Inspection(
      id: json["id"] ?? 0,
      photo: json["photo"] ?? '',
      code: json["code"] ?? '',
      odometer: json["odometer"] ?? 0,
      photoContentType: json["photoContentType"] ?? '',
      completed: json["completed"] ?? '',
      result: json['result'],
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
    };
  }
}