// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import '../../utils/theme/controllers/gradient_theme_controllers.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(image),
          height: size.height * 0.2,
        ),
        Text(
          tr('SignupTitle'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
            foreground: Paint()
              ..shader = ThemeController.to.horizontalGradientShader,
          ),
        ),
        Text(
          tr('SignupSubtitle'),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
            foreground: Paint()
              ..shader = ThemeController.to.horizontalGradientShader2,
          ),
        )
      ],
    );
  }
}
