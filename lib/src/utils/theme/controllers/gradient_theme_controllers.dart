import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  late final Shader verticalGradientShader;
  late final Shader horizontalGradientShader;
  late final Shader horizontalGradientShader2;

  @override
  void onInit() {
    super.onInit();

    verticalGradientShader = LinearGradient(
      colors: [Color.fromARGB(255, 79, 214, 83), Colors.blue],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 200.0));

    //left to right
    horizontalGradientShader = LinearGradient(
      colors: [Color.fromARGB(255, 79, 214, 83), Colors.blue],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 200.0));

    // right to left
    horizontalGradientShader2 = LinearGradient(
      colors: [
        Colors.blue,
        Color.fromARGB(255, 79, 214, 83),
      ],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 200.0));
  }
}
