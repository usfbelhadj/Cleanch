import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myflutter/src/constants/colors.dart';
import 'package:myflutter/src/constants/sizes.dart';
import 'package:myflutter/src/features/app/controllers/locale_controller.dart';
import 'package:myflutter/src/features/app/profile/update_profil.dart';
import 'package:myflutter/src/features/app/profile/widgets/profile_menu.dart';
import 'package:myflutter/src/features/app/profile/widgets/profile_menu_para.dart';
import 'package:myflutter/src/features/authentification/models/user/user_controller.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import '../home/home.dart';
import '../inforamtions/info.dart';
import 'user_interrests.dart';

class UserProfile extends StatelessWidget {
  static const String routeName = '/profile'; // for nav bar route

  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocaleController localeController = Get.find();

    final date = "12/10/2024";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 150, 222, 255),
        leading: IconButton(
          onPressed: () => Get.offAll(HomeScreen()),
          icon: const Icon(LineAwesomeIcons.angle_left),
          // if dark mode color is white else color is black
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
        title: Obx(() {
          return Text(
            tr('profiletext'),
            style: Theme.of(context).textTheme.headlineSmall,
          );
        }),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(DefaultSize),
            child: Column(
              children: [
                ProfileMenuWidget(
                  icon: Icons.person_outline,
                  title: 'Youssef' + ' ' + 'Belhadj',
                ),
                ProfileMenuWidget(
                  icon: Icons.phone_outlined,
                  title: "54318841",
                ),
                ProfileMenuWidget(
                  icon: Icons.email_outlined,
                  title: "usf.belhadj@gmail.com",
                ),
                ProfileMenuWidget(
                  icon: Icons.check_circle_outline,
                  title: tr('yearlySub') + ' ' + "${date}",
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => UpdateProfileScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 150, 222, 255),
                      side: BorderSide.none,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(tr('EditProfile'),
                        style: TextStyle(color: DarkColor)),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(height: 10, color: Colors.grey),
                ProfileMenuParaWidget(
                  endIcon: true,
                  title: tr('interreststext'),
                  icon: LineAwesomeIcons.map,
                  onPressed: () {
                    Get.to(() => InterestPage());
                  },
                ),
                const Divider(height: 10, color: Colors.grey),
                const SizedBox(height: 30),
                ProfileMenuParaWidget(
                  endIcon: true,
                  title: tr('languageChange'),
                  icon: LineAwesomeIcons.cog,
                  onPressed: () {
                    Get.defaultDialog(
                      title: tr('selectLanguage').toUpperCase(),
                      titleStyle: const TextStyle(fontSize: 20),
                      content: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text('English'),
                              onTap: () {
                                localeController.changeLocale(Locale('en'));
                                Get.back();
                              },
                            ),
                            ListTile(
                              title: Text('Français'),
                              onTap: () {
                                localeController.changeLocale(Locale('fr'));
                                Get.back();
                              },
                            ),
                            ListTile(
                              title: Text('Italiano'),
                              onTap: () {
                                localeController.changeLocale(Locale('it'));
                                Get.back();
                              },
                            ),
                            ListTile(
                              title: Text('Deutsch'),
                              onTap: () {
                                localeController.changeLocale(Locale('de'));
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 30),
                ProfileMenuParaWidget(
                    endIcon: true,
                    title: tr('InformationsText'),
                    icon: LineAwesomeIcons.info,
                    onPressed: () {
                      Get.to(() => const Info());
                    }),
                const SizedBox(height: 30),
                const Divider(height: 10, color: Colors.grey),
                const SizedBox(height: 30),
                const SizedBox(height: 10),
                ProfileMenuParaWidget(
                  title: tr('logout'),
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPressed: () {
                    Get.defaultDialog(
                      title: tr('logout').toUpperCase(),
                      titleStyle: const TextStyle(fontSize: 20),
                      content: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text(tr('acceptlogoutText')),
                      ),
                      confirm: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              side: BorderSide.none,
                            ),
                            child: Text(tr('yesText')),
                          ),
                          OutlinedButton(
                            onPressed: () => Get.back(),
                            child: Text(tr('noText')),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
