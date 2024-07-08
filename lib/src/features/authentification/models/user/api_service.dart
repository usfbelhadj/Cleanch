import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Map<String, dynamic>> verifyOTP(
      String phoneNumber, String otp) async {
    final response = await http.post(
      Uri.parse('http://api.cleanchtraffic.com:5000/api/auth/otp/'),
      body: {
        'phone': phoneNumber,
        'otp': otp,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  static Future<Map<String, dynamic>> fetchUserData(String accessToken) async {
    final userResponse = await http.get(
      Uri.parse('http://api.cleanchtraffic.com:5000/api/currentUser/'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (userResponse.statusCode == 200) {
      return json.decode(userResponse.body);
    } else {
      throw Exception('Failed to fetch user data');
    }
  }

  static Future<void> sendFCMInfo(Map<String, dynamic> payload) async {
    try {
      final response = await http.post(
        Uri.parse('http://api.cleanchtraffic.com:5000/api/auth/fcm/create/'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      if (response.statusCode == 201) {
        print('FCM Info sent successfully');
      } else if (response.statusCode == 404) {
        await http.put(
          Uri.parse(
              'http://api.cleanchtraffic.com:5000/api/fcm/${payload['registration_id']}/'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode(payload),
        );
        print('now Upadtes');
      } else {
        print(
            'Failed to send FCM Info ${response.statusCode} ${response.request}');
      }
    } catch (e) {
      print(e);
    }
  }
}

