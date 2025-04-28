import 'package:flutter/material.dart';
import 'package:app/utils/constants/colors.dart';

class GuapliChipTheme{
  GuapliChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withAlpha((.4 * 255).toInt()),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: GuapliColors.primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: GuapliColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: GuapliColors.darkerGrey,
    labelStyle: TextStyle(color: Colors.white),
    selectedColor: GuapliColors.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: GuapliColors.white,
  );

}