import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> reverseGeocode(double long, double lat) async {
  final url = Uri.parse('https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$long');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    return "${data['address']["road"]}, ${data['address']['city'] ?? data['address']['town'] ?? data['address']['state'] ?? data['address']['country']}";
  } else {
    return "No location found";
  }
}