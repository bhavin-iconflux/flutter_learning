import 'package:flutter/material.dart';
import 'package:flutter_learning/utils/color.dart';

class TextStyles {
  static const textFieldLabelStyle =
      TextStyle(fontSize: 14, fontFamily: 'Zurich', color: Palette.colorABABAB);

  static const textFieldHintStyle =
      TextStyle(fontSize: 18, fontFamily: 'Zurich', color: Palette.color575757);

  static const titleH2 = TextStyle(
      fontSize: 30, fontFamily: 'Zurich', fontWeight: FontWeight.w600, color: Palette.color333333);

  static const textSmall =
      TextStyle(fontSize: 16, fontFamily: 'Zurich', color: Palette.color2167AE);

  static const buttonText =
      TextStyle(fontSize: 18, fontFamily: 'Zurich', fontWeight: FontWeight.w600);

  static const notificationText =
  TextStyle(fontSize: 18, fontFamily: 'Zurich', color: Colors.black);
}
