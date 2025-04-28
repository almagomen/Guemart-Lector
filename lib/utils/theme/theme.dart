import 'package:flutter/material.dart';
import 'package:app/utils/constants/colors.dart';
import 'package:app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:app/utils/theme/custom_themes/text_theme.dart';

import 'package:app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:app/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:app/utils/theme/custom_themes/chip_theme.dart';
import 'package:app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:app/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:app/utils/theme/custom_themes/text_field_theme.dart';



class GuapliAppTheme {
  GuapliAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: GuapliColors.grey,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    textTheme: GuapliTextsheme.lightTextsTheme,
    chipTheme: GuapliChipTheme.lightChipTheme,
    scaffoldBackgroundColor: GuapliColors.light,
    appBarTheme: GuapliAppBarTheme.lighGuapliAppBarTheme,
    checkboxTheme: GuapliCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: GuapliBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: GuapliElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: GuapliOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: GuapliTextsFormFieldTheme.lightTextsFormFieldTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: GuapliColors.grey,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    textTheme: GuapliTextsheme.darkTextTheme,
    chipTheme: GuapliChipTheme.darkChipTheme,
    scaffoldBackgroundColor: GuapliColors.black,
    appBarTheme: GuapliAppBarTheme.darkAppBarTheme,
    checkboxTheme: GuapliCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: GuapliBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: GuapliElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: GuapliOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: GuapliTextsFormFieldTheme.darkTextFormFieldTheme,
  );
}