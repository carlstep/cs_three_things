import 'package:flutter/material.dart';

class AppStyles {
  // COLOR OPTIONS
  static Color selectedIconColor = Colors.red;
  static Color unselectedIconColor = Colors.blueGrey;

  // TEXT STYLES - headings
  static TextStyle headlineStyle1 = const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      letterSpacing: 2,
      color: Colors.blueGrey);

  // TEXT STYLES
  // - fixed text

  static TextStyle textLabelStyle1 =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w400);
  static TextStyle textLabelStyle2 =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w700);
  static TextStyle textHintStyle =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w400);

  // - text input
  static TextStyle textInputStyle1 =
      const TextStyle(fontSize: 22, fontWeight: FontWeight.w300, height: 0.8);
  static TextStyle textInputStyle2 =
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w300, height: 0.8);
  static TextStyle textTagInputStyle3 =
      const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 0.8);

  // BORDER STYLES
  static BorderSide inputBorderStyle =
      const BorderSide(color: Colors.black, width: 0.5);
  static BorderSide focusedBorderStyle =
      const BorderSide(color: Colors.red, width: 0.5);
}
