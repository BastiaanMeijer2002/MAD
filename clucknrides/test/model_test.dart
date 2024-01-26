import 'package:flutter_test/flutter_test.dart';
import 'package:clucknrides/models/Car.dart'; // Replace with your actual import path

void main() {
  group('Car Model Tests', () {
    test('fromJson returns a valid Car object', () {
      var json = {
        'id': 1,
        'brand': 'Ford',
        'model': 'Fiesta',
        'nrOfSeats': 5,
        'fuel': 'Petrol',
        'img': 'fiesta.png',
        'price': 10000.0,
        'engineSize': 1500,
        'modelYear': 2021,
        'longitude': -0.1257,
        'latitude': 51.5085
      };

      var car = Car.fromJson(json);

      expect(car.id, 1);
      expect(car.brand, 'Ford');
      expect(car.model, 'Fiesta');
      expect(car.nrOfSeats, 5);
      expect(car.fuel, 'Petrol');
      expect(car.img, 'fiesta.png');
      expect(car.price, 10000.0);
      expect(car.engineSize, 1500);
      expect(car.modelYear, 2021);
      expect(car.longitude, -0.1257);
      expect(car.latitude, 51.5085);
    });

    test('toJson returns a valid map', () {
      var car = Car(
          id: 1,
          brand: 'Ford',
          model: 'Fiesta',
          nrOfSeats: 5,
          fuel: 'Petrol',
          img: 'fiesta.png',
          price: 10000.0,
          engineSize: 1500,
          modelYear: 2021,
          longitude: -0.1257,
          latitude: 51.5085
      );

      var json = car.toJson();

      expect(json['id'], 1);
      expect(json['brand'], 'Ford');
      expect(json['model'], 'Fiesta');
      expect(json['nrOfSeats'], 5);
      expect(json['fuel'], 'Petrol');
      expect(json['img'], 'fiesta.png');
      expect(json['price'], 10000.0);
      expect(json['engineSize'], 1500);
      expect(json['modelYear'], 2021);
      expect(json['longitude'], -0.1257);
      expect(json['latitude'], 51.5085);
    });
  });

  test('Car constructor sets fields correctly', () {
    var car = Car(
        id: 1,
        brand: 'Ford',
        model: 'Fiesta',
        nrOfSeats: 5,
        fuel: 'Petrol',
        img: 'fiesta.png',
        price: 10000.0,
        engineSize: 1500,
        modelYear: 2021,
        longitude: -0.1257,
        latitude: 51.5085
    );

    expect(car.id, 1);
    expect(car.brand, 'Ford');
    expect(car.model, 'Fiesta');
    expect(car.nrOfSeats, 5);
    expect(car.fuel, 'Petrol');
    expect(car.img, 'fiesta.png');
    expect(car.price, 10000.0);
    expect(car.engineSize, 1500);
    expect(car.modelYear, 2021);
    expect(car.longitude, -0.1257);
    expect(car.latitude, 51.5085);
  });
}
