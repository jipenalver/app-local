import 'package:flutter/material.dart';

class ColorsUtil {
  // Primary Color
  static const int primary = 0xffFAA0A0;
  // Secondary Color
  static const int secondary = 0xffFAA0A0;
  // Surface Color
  static const int surface = 0xff202020;

  // AppBar Color
  static const int appBar = 0xffFAA0A0;
  // Main Button Color
  static const int mainBtn = 0xffE30B5C;
  // List Subtitle Color
  static const int subtitle = 0xffBEBEBE;

  static ColorScheme darkMode() {
    return ColorScheme.dark(
        primary: Color(primary),
        secondary: Color(secondary),
        surface: Color(surface));
  }
}
