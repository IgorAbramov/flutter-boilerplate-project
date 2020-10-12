import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can instantiate this class

  static const Color white = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFF03A9F4);
  static const Color lightBlue = Colors.lightBlueAccent;
  static const Color lightGray = Color(0xFFBDBDBD);
  static const Color gray = Colors.black54;
  static const Color darkGray = Color(0xFF212121);
  static const Color black = Color(0xFF000000);
  static const Color red = Color(0xFFFF5252);

  static const Map<int, Color> blackPalette = const <int, Color>{
    50: const Color(0xFF212121),
    100: const Color(0xFF212121),
    200: const Color(0xFF212121),
    300: const Color(0xFF212121),
    400: const Color(0xFF212121),
    500: const Color(0xFF000000),
    600: const Color(0xFF000000),
    700: const Color(0xFF000000),
    800: const Color(0xFF000000),
    900: const Color(0xFF000000),
  };
}
