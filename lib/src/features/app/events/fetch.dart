import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> fetchEventAddress(double latitude, double longitude) async {
  final apiUrl = 'http://khaledxab.pythonanywhere.com/';
  final Map<String, dynamic> requestData = {
    "latitude": latitude.toString(),
    "longitude": longitude.toString(),
  };

  final response = await http.post(Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData));

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final String address = responseData['address'] ?? 'Address not found';
    return address;
  } else {
    throw Exception('Failed to fetch address');
  }
}
