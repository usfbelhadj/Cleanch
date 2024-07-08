// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myflutter/src/common_widgets/form/form_header_widget.dart';
import 'package:myflutter/src/constants/image_strings.dart';
import 'package:myflutter/src/constants/sizes.dart';
import 'package:myflutter/src/features/authentification/screens/signup/widgets/signup_form_widget.dart';
import 'package:myflutter/src/utils/translation/translation.dart';

import '../login/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(DefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormHeaderWidget(
                    image: welcomeImage,
                    title: tr('SignupTitle'),
                    subTitle: tr('SignupSubtitle'),
                  ),
                  const SignUpFormWidget(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(tr('orText')),
                      const SizedBox(height: FormHeight - 20),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                            onPressed: () {
                              Get.to(() => LoginScreen());
                            },
                            icon: const Image(
                              image: AssetImage(lock),
                              width: 20,
                            ),
                            label: Text(tr('Login').toUpperCase())),
                      ),
                      // const SizedBox(height: tFormHeight - 20),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
