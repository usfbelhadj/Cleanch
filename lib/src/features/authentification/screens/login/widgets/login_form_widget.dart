import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:myflutter/src/constants/phoneTextFiels.dart';
import 'package:myflutter/src/features/authentification/models/user/check_phone.dart';
import 'package:myflutter/src/features/authentification/screens/signup/signup_screen.dart';
import 'package:myflutter/src/utils/translation/translation.dart';
import '../../../../../constants/sizes.dart';
import '../../otp/otp_screen.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController phoneController = TextEditingController();

  Future<void> _handleLoginButtonPressed(String phoneNumber) async {
    bool phoneNumberExists = await checkPhoneNumberExists(phoneNumber);

    if (phoneNumberExists) {
      Get.to(
          () => OTPScreen(phoneNumber: phoneNumber)); // Navigate to OTP screen
    } else {
      Get.to(() => SignUpScreen()); // Navigate to registration screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PhoneTextField(
              controller: phoneController,
              hintText: tr('phoneNumber'),
              obscureText: false,
            ),
            const SizedBox(height: FormHeight - 20),
            const SizedBox(height: FormHeight - 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String phoneNumber = phoneController.text;
                  if (phoneNumber.isEmpty) {
                    Get.snackbar(
                      tr('error'),
                      tr('phoneNumberRequired'),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.redAccent.shade400,
                      colorText: Colors.white,
                    );
                    return;
                  } else
                    _handleLoginButtonPressed(phoneNumber);
                },
                child: Text(tr('Login').toUpperCase()),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blueAccent.shade400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
