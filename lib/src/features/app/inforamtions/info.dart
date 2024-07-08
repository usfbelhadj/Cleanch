import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import '../../../constants/image_strings.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 150, 222, 255),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
          // if dark mode color is white else color is black
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        title: Obx(() {
          return Text(
            tr('InformationsText'),
            style: Theme.of(context).textTheme.headlineSmall,
          );
        }),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 400,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Text(
                  tr('Appname'),
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 8),
                Image(
                  image: AssetImage(SplashTopIcon),
                  fit: BoxFit.cover,
                  opacity: AlwaysStoppedAnimation(0.7),
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 8),
                Text(
                  tr('Appversion'),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    tr('AboutText'),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  tr('devByText'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
