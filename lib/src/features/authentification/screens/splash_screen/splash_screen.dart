import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myflutter/src/constants/image_strings.dart';

import 'package:myflutter/src/features/authentification/controllers/splash_screen_controller.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color
      body: Stack(
        children: [
          // Static Splash Image (No animation)
          const Positioned.fill(
            child: Image(
                image: AssetImage(SplashImage),
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.7)),
          ),

          // Animated Top Icon with Fade-out Animation
          Obx(
            () => AnimatedOpacity(
              duration: const Duration(milliseconds: 1600),
              opacity: splashController.animate.value ? 1 : 0,
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(SplashTopIcon)),
                    Text(tr('Appname'),
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 40,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
