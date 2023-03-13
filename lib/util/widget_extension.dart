import 'package:flutter/cupertino.dart';

class Spaces {
  static EdgeInsets verticalAndHorizontal({double vertical = 0, double horizontal = 0}) =>
    EdgeInsets.only(top: vertical, bottom: vertical, left: horizontal, right: horizontal);
}
