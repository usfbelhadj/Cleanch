import 'package:flutter/material.dart';
import 'package:myflutter/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:myflutter/src/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:myflutter/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:myflutter/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._(); // private class constructor

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: KTextTheme.lightTextTheme,
    outlinedButtonTheme: KOutlinedButtonTheme.ligtOutlinedButtonTheme,
    elevatedButtonTheme: KElevatedButtonTheme.lightElevatedButton,
    inputDecorationTheme: KTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: KTextTheme.darkTextTheme,
    outlinedButtonTheme: KOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: KElevatedButtonTheme.darkElevatedButton,
    inputDecorationTheme: KTextFormFieldTheme.darkInputDecorationTheme,
  );
}
