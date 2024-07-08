import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:get/get.dart';
import 'package:myflutter/src/features/app/controllers/event_model.dart';
import '../../authentification/models/user/user_controller.dart';

class EventApi {
  final userController = UserController();
  static Future<List<Event>> fetchEvents() async {
    final userController = Get.find<UserController>();
    final accessToken = userController.accessToken;
    final response = await http.get(
      Uri.parse('http://api.cleanchtraffic.com:5000/api/events/list'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> eventData = jsonDecode(response.body);
      final List<Event> fetchedEvents = eventData.map((event) {
        return Event(
          eventId: event['event_id'],
          eventType: event['event_type'],
          eventDate: DateTime.parse(event['event_date']),
          latitude: double.parse(event['latitude']),
          longitude: double.parse(event['longitude']),
          message: event['message'] ?? "No Message",
        );
      }).toList();

      return fetchedEvents;
    } else {
      print('Check Your Connection');
      userController.logout();

      return [];
    }
  }
}
