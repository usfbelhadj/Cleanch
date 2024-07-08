import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutter/src/constants/sizes.dart';

import '../welcome/welcome_screen.dart';
import 'widgets/login_form_widget.dart';
import 'widgets/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Get.offAll(WelcomeScreen());
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(DefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginHeaderWidget(size: size),
                  LoginForm(),

                  // const LoginFooterWidget()
                ],
              )),
        )),
      ),
    );
  }
}
