import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:myflutter/src/constants/sizes.dart';

import 'package:myflutter/src/features/authentification/models/user/user_controller.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

class settingsPage extends StatelessWidget {
  static const String routeName = '/settings'; // for nav bar route
  const settingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final userController = Get.find<UserController>();
    // ignore: unused_local_variable
    final userData =
        userController.userData.value; // Access the actual map value

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 150, 222, 255),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Center(
          child: Text(
            tr('settingText'),
            // ignore: deprecated_member_use
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(LineAwesomeIcons.bell),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(DefaultSize),
          child: Center(child: Column(children: [Text("hi")])),
        ),
      ),
    );
  }
}
