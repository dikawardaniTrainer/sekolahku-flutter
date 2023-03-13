// ignore_for_file: avoid_print

import 'package:sekolah_ku/theory/dart/variables.dart';
import 'package:sekolah_ku/theory/dart/function.dart';
import 'package:sekolah_ku/theory/dart/classes.dart';

void main() {
  sampleVariableDeclaration();
  print("=========STRING=============");
  sampleStringData();
  print("=========INT==================");
  sampleInt();
  print("============MAPS=============");
  sampleMaps();
  print("===========LIST=================");
  sampleList();
  print("===========FUNCTION=================");
  print(findFirstGift());
  print(findGiftByKey("second"));
  print(findGiftByKey("xxx"));
  print("===========CLASSES=================");
  sampleCreateClassObject();
  sampleInheritance();
  sampleOptionalParameter();
}