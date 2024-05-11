import 'package:flutter/material.dart';

class size_config {
  static double? screen_height;
  static double? screen_width;
  static double? default_size;
  static Orientation? orientation;
  void init(BuildContext context) {
    screen_height = MediaQuery.of(context).size.height;
    screen_width = MediaQuery.of(context).size.width;
    orientation = MediaQuery.of(context).orientation;
    default_size = (orientation == Orientation.landscape)
        ? screen_height! * 0.024
        : screen_width! * 0.024;
  }
}
