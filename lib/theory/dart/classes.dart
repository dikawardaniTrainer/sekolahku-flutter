// ignore_for_file: avoid_print

import 'package:sekolah_ku/theory/dart/vehicles/car.dart';
import 'package:sekolah_ku/theory/dart/vehicles/motor.dart';
import 'package:sekolah_ku/theory/dart/vehicles/vehicle.dart';

void sampleCreateClassObject() {
  var car = Car();
  car.brand = "Toyota";
  car.id = "F 77844 AD";

  print(car);
  print(car.id);
  print(car.brand);
  print("current speed : ${car.getSpeed()}, current gear: ${car.getGear()}");
  car.increaseSpeedBy(10);
  print("current speed : ${car.getSpeed()}, current gear: ${car.getGear()}");
  car.increaseSpeedBy(20);
  print("current speed : ${car.getSpeed()}, current gear: ${car.getGear()}");
  car.increaseSpeedBy(30);
  print("current speed : ${car.getSpeed()}, current gear: ${car.getGear()}");
}

void sampleInheritance() {
  var car = Car();
  car.brand = "Toyota";
  car.id = "F 77844 AD";

  var motor = Motor();
  motor.brand = "Yamaha";
  motor.id = "F 7364 AD";

  List<Vehicle> vehicles = [];
  vehicles.add(car);
  vehicles.add(motor);

  car.increaseSpeedBy(110);
  motor.increaseSpeedBy(110);
  print(car);
  print(motor);
  print(vehicles);
}

void sampleOptionalParameter() {
  var car1 = Car();
  var car2 = Car(id: "F 424 HJ");
  var motor1 = Motor();
  var motor2 = Motor("Kawasaki", "F 4542 JK");

  print(car1);
  print(car2);
  print(motor1);
  print(motor2);
  print(car2);
}