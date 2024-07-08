// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myflutter/src/constants/colors.dart';
import 'package:myflutter/src/constants/sizes.dart';
import 'package:myflutter/src/features/authentification/screens/login/login_screen.dart';
import 'package:myflutter/src/utils/theme/controllers/gradient_theme_controllers.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import '../../../../constants/image_strings.dart';
import '../../../app/controllers/locale_controller.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final LocaleController localeController = Get.find();

  Widget buildLanguageTile(String language, String flagAsset, String locale) {
    return ListTile(
      title: Row(
        children: [
          SvgPicture.asset(
            flagAsset,
            width: 30,
            height: 30,
          ),
          SizedBox(width: 10.0),
          Text(language),
        ],
      ),
      onTap: () {
        localeController.changeLocale(Locale(locale));
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? SecondaryColor : CardBgColor,
      body: Obx(() {
        return Container(
          padding: const EdgeInsets.all(DefaultSize),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 0.0),
                GestureDetector(
                  onTap: () {
                    Get.defaultDialog(
                      title: tr('selectLanguage').toUpperCase(),
                      titleStyle: const TextStyle(fontSize: 20),
                      content: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            buildLanguageTile('English',
                                'assets/images/flags/UK-union-flag.svg', 'en'),
                            buildLanguageTile(
                                'Français',
                                'assets/images/flags/frenchflagframed.svg',
                                'fr'),
                            buildLanguageTile(
                                'Italiano',
                                'assets/images/flags/tobias-Flag-of-Italy.svg',
                                'it'),
                            buildLanguageTile(
                                'Deutsch',
                                'assets/images/flags/Anonymous-Flag-of-Germany.svg',
                                'de'),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 64, 202, 236)
                                    .withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 0.5,
                                offset: const Offset(
                                    0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.transparent),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                LineAwesomeIcons.globe,
                                color: Color.fromARGB(255, 0, 153, 255),
                                size: 25,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromRGBO(63, 204, 50, 1),
                                size: 22,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Image(
                    image: const AssetImage(welcomeImage),
                    height: height * 0.4),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          tr('WelcomeTitle'),
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 40,
                              foreground: Paint()
                                ..shader =
                                    ThemeController.to.horizontalGradientShader,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          tr('WelcomeTitle2'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0,
                            foreground: Paint()
                              ..shader =
                                  ThemeController.to.horizontalGradientShader2,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      tr('WelcomeSubtitle'),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.to(() => const LoginScreen()),
                        child: Text(tr('Continue').toUpperCase()),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                  ],
                )
              ]),
        );
      }),
    );
  }
}
