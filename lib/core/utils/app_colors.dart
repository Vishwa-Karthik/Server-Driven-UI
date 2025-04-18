import 'package:flutter/material.dart';

class AppColors {
  static Color? parseColor(String? hexColor) {
    if (hexColor == null || !hexColor.startsWith('#')) return null;
    debugPrint(Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000).toString());
    return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
  }
}
