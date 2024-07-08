import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class KOutlinedButtonTheme {
  KOutlinedButtonTheme._(); // private class constructor

  static final ligtOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      foregroundColor: SecondaryColor,
                      side: const BorderSide(color: SecondaryColor),
                      padding: const EdgeInsets.symmetric(vertical: ButtonHeight),
                    ),
  );
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(),
                      foregroundColor: WhiteColor,
                      side: const BorderSide(color: WhiteColor),
                      padding: const EdgeInsets.symmetric(vertical: ButtonHeight),
                    ),
  );
}
