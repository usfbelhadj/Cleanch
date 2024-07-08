// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import '../../../../../constants/image_strings.dart';
import '../../../../../utils/theme/controllers/gradient_theme_controllers.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: const AssetImage(welcomeImage),
            height: size.height * 0.3,
          ),
        ),
        Text(
          tr('LoginTitle'),
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 40,
              foreground: Paint()
                ..shader = ThemeController.to.horizontalGradientShader,
              fontWeight: FontWeight.w700),
        ),
        Text(tr('LoginSubtitle'), style: Theme.of(context).textTheme.bodyText1),
      ],
    );
  }
}
