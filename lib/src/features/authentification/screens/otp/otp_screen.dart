import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myflutter/src/features/authentification/controllers/otp_logic/otp_logic.dart';
import 'package:myflutter/src/utils/translation/translation.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../utils/theme/controllers/gradient_theme_controllers.dart';
import '../login/login_screen.dart';

class OTPScreen extends StatelessWidget {
  final String phoneNumber;

  OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String part1 = phoneNumber.substring(0, 3);
    String part2 = phoneNumber.substring(3, 6);
    String part3 = phoneNumber.substring(6, 8);
    // String part4 = phoneNumber.substring(8);

    String separatedNumber = "$part1-$part2-$part3";
    final otpController = TextEditingController();

    return WillPopScope(
      onWillPop: () {
        Get.offAll(LoginScreen());
        return Future.value(true);
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(DefaultSize),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tr('OtpTitle'),
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 80.0, // Adjusted font size
                      foreground: Paint()
                        ..shader = ThemeController.to.verticalGradientShader,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(tr('OtpSubtitle').toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = ThemeController.to.verticalGradientShader,
                      )),
                  const SizedBox(height: 40.0),
                  Text(
                    (tr('Otp')),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    separatedNumber,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    decoration: InputDecoration(
                      hintText: tr('enterOtptxt'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (otpController.text == '' ||
                            otpController.text.length < 6) {
                          Get.snackbar(
                            tr('error'),
                            tr('enterOtptxt'),
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }
                        ;
                        await OTPLogic.onPressed(
                          phoneNumber: phoneNumber,
                          otpController: otpController,
                          context: context,
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      ),
                      child: Text(tr('Next').toUpperCase()),
                    ),
                  ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
