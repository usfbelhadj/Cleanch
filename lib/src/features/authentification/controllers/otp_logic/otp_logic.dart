import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myflutter/src/features/authentification/models/user/api_service.dart';
import 'package:myflutter/src/features/authentification/models/user/user_controller.dart';
import 'package:android_id/android_id.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class OTPLogic {
  static Future<void> onPressed({
    required String phoneNumber,
    required TextEditingController otpController,
    required BuildContext context,
  }) async {
    try {
      final otp = otpController.text;
      final phone = phoneNumber;
      final response = await ApiService.verifyOTP(phone, otp);
      final accessToken = response['token']['access'];
      final refreshToken = response['token']['refresh'];
      final box = GetStorage();
      box.write('accessToken', accessToken);
      box.write('refreshToken', refreshToken);

      final userData = await ApiService.fetchUserData(accessToken);
      String? osId = '';
      final os = Platform.operatingSystem;
      print(os);
      if (os == 'android') {
        final androidIdPlugin = AndroidId();
        osId = await androidIdPlugin.getId();
      } else {
        final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        final iosInfo = await deviceInfo.iosInfo;
        osId = iosInfo.identifierForVendor;
      }

      final firebaseMessaging = FirebaseMessaging.instance;
      final String? fcmToken = await firebaseMessaging.getToken();

      final user = userData['id'];

      final payload = {
        "name": userData['first_name'],
        "active": true,
        "registration_id": fcmToken,
        "type": os,
        "user": user,
        "device_id": osId,
      };

      await ApiService.sendFCMInfo(payload);

      final userController = Get.find<UserController>();
      userController.setUserLoggedIn(true);
      userController.setUserData(userData);
      userController.setAccessToken(accessToken);

      Get.offAllNamed('/home');
    } catch (e) {
      print('Error: $e');
    }
  }
}
