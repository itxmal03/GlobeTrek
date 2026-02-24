import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screensHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screensHeight = size.height;
  }

  static double hp(double percent) => screensHeight * percent / 100;
  static double wp(double percent) => screenWidth * percent / 100;
}
