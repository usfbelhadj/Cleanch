import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../authentification/models/user/api_service.dart';
import '../../../authentification/models/user/user_controller.dart';

Future<void> editProfile(Map<String, dynamic> payload) async {
  final _userController = Get.find<UserController>();
  final box = GetStorage();
  final accessToken = box.read('accessToken');
  final response = await http.put(
    Uri.parse('http://api.cleanchtraffic.com:5000/api/currentUser/'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    },
    body: json.encode(payload),
  );

  if (response.statusCode == 200) {
    // Update the user's profile data using the UserController's updateProfile method

    final userData = await ApiService.fetchUserData(accessToken);
    _userController.setUserData(userData);

    // Display a success message
    Get.snackbar('Success', 'Profile info edited successfully');

    // Navigate back to the previous screen (profile screen)
    Get.back();
  } else {
    throw Exception(response.body);
  }
}
