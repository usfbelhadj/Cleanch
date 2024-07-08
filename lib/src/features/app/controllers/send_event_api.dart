import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'dart:convert';

import '../../authentification/models/user/user_controller.dart';

class EventService {
  Future<void> sendEvent(String eventType, LatLng currentLocation) async {
    final userController = Get.find<UserController>();
    final accessToken = userController.accessToken;

    final latitude = currentLocation.latitude.toStringAsFixed(6);
    final longitude = currentLocation.longitude.toStringAsFixed(6);

    // ignore: unnecessary_null_comparison
    if (currentLocation != null) {
      try {
        final response = await http.post(
          Uri.parse('http://api.cleanchtraffic.com:5000/api/events/init/'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $accessToken',
          },
          body: jsonEncode({
            'event_type': eventType,
            'latitude': latitude,
            'longitude': longitude,
            'event_date': DateTime.now().toUtc().toIso8601String(),
          }),
        );

        if (response.statusCode == 200) {
          print('Event sent successfully');
        } else {
          print(response.body);
        }
      } catch (e) {
        print('Error sending event: $e');
      }
    }
  }
}
