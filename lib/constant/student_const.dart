import 'package:flutter/foundation.dart';

final genderOptions = ["Male", "Female"];
final educationOptions = ["*** Please select one education ***", "SD", "SMP", "SMA", "S1"];
final hobiesOptions = ["Reading", "Writing", "Drawing"];
final minimumBirthDate = DateTime(1990);
final maxBirthDate = DateTime(2016);
const datePattern = 'EEEEE, dd MMMM yyyy';
bool get useDummyLoading => kDebugMode && true;