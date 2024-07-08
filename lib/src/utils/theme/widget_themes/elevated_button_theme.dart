import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class KElevatedButtonTheme {
  KElevatedButtonTheme._(); // private class constructor

  static final lightElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: WhiteColor,
      backgroundColor: SecondaryColor,
      padding: const EdgeInsets.symmetric(vertical: ButtonHeight),
    ),
  );
  static final darkElevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: SecondaryColor,
      backgroundColor: WhiteColor,
      padding: const EdgeInsets.symmetric(vertical: ButtonHeight),
    ),
  );
}
