import 'package:sekolah_ku/theory/dart/vehicles/vehicle.dart';

class Motor extends Vehicle {

  Motor([String brand = "UNKNOWN", String id = "UNKNOWN"]) {
    this.brand = brand;
    this.id = id;
  }

  @override
  int getGear() {
    final currentSpeed = getSpeed();

    if(currentSpeed == 0) {
      return 0;
    } else if(currentSpeed > 0 && currentSpeed <= 20) {
      return 1;
    } else if (currentSpeed > 0 && currentSpeed <= 40) {
      return 2;
    } else if(currentSpeed > 0 && currentSpeed <= 60) {
      return 3;
    } else {
      return 4;
    }
  }

  @override
  int getTotalWheels() {
    return 2;
  }
}
