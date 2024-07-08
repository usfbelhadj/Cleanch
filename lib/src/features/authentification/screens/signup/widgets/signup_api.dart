import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../otp/otp_screen.dart';

class singupApi {
  static Future<void> submitRegistration({
    required String email,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    final url =
        Uri.parse("http://api.cleanchtraffic.com:5000/api/auth/registration/");
    final response = await http.post(url, body: {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
    });

    if (response.statusCode == 201) {
      // go to login page
      Get.to(() => OTPScreen(phoneNumber: phone));
      print("Registration successful");
    } else {
      print("Registration failed with status code: ${response.statusCode}");
      print("Response body: ${response.body}");
    }
  }
}
