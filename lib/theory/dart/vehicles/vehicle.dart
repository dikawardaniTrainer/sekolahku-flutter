
import 'package:flutter/foundation.dart';

abstract class Vehicle {
  String? brand;
  String? id;
  int _currentSpeed = 0;

  @nonVirtual
  void increaseSpeedBy(int speedToAdd) {
    if (speedToAdd.isNegative) throw Exception("Speed cannot be negative");
    _currentSpeed += speedToAdd;
  }

  @nonVirtual
  int getSpeed() {
    return _currentSpeed;
  }

  int getTotalWheels();

  int getGear();

  @override
  String toString() {
    return "[brand : $brand, id : $id, currentSpeed : ${getSpeed()}, gear: ${getGear()}, total wheels: ${getTotalWheels()}]";
  }
}
