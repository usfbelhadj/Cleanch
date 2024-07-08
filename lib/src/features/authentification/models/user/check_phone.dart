import 'package:http/http.dart' as http;
import 'dart:convert';

Future<bool> checkPhoneNumberExists(String phoneNumber) async {
  final url = Uri.parse('http://api.cleanchtraffic.com:5000/api/auth/phone_exists/');
  final response = await http.post(
    url,
    body: jsonEncode({"phone": phoneNumber}),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode == 200) {
    return true; // Phone number exists
  } else if (response.statusCode == 404) {
    return false; // Phone number doesn't exist
  } else {
    throw Exception('Failed to check phone number existence');
  }
}

