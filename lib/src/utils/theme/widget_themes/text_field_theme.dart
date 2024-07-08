import 'package:flutter/material.dart';
import 'package:myflutter/src/constants/colors.dart';

class KTextFormFieldTheme {
  KTextFormFieldTheme._(); // private class constructor

  static InputDecorationTheme lightInputDecorationTheme =
      const InputDecorationTheme(
          border: OutlineInputBorder(),
          prefixIconColor: SecondaryColor,
          floatingLabelStyle: TextStyle(color: SecondaryColor),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: SecondaryColor)));

  static InputDecorationTheme darkInputDecorationTheme =
      const InputDecorationTheme(
          border: OutlineInputBorder(),
          prefixIconColor: PrimaryColor,
          floatingLabelStyle: TextStyle(color: PrimaryColor),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: PrimaryColor)));
}
