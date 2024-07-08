import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../authentification/models/user/user_controller.dart';

import 'package:http/http.dart' as http;

class LocationController extends GetxController {
  final userController = Get.find<UserController>();
  final box = GetStorage();

  bool isItemInJson(item) {
    var jsonData = box.read('locationPreferences');
    // Check if the item is in preferred_locations

    if (jsonData["preferred_locations"].contains(item)) {
      return true;
    }

    // Check if the item is in preferred_autoroute
    if (jsonData["preferred_autoroute"].contains(item)) {
      return true;
    }

    // Check if the item is in preferred_frontier
    if (jsonData["preferred_frontier"].contains(item)) {
      return true;
    }

    // Item not found in any of the arrays
    return false;
  }

  Future<Map<String, dynamic>> getLocationOfuser() async {
    final accessToken = userController.accessToken;

    final response = await http.get(
      Uri.parse(
          'http://api.cleanchtraffic.com:5000/api/currentUser/location_preferences/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json;charset=utf-8',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      box.write(
          'locationPreferences', jsonDecode(utf8.decode(response.bodyBytes)));
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Invalid response format. Expected a list of strings.');
    }
  }

  Future<List<dynamic>> fetchRegions() async {
    final accessToken = userController.accessToken;

    final response = await http.get(
      Uri.parse('http://api.cleanchtraffic.com:5000/api/location/regions/'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json charset=utf-8',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> regionList =
          jsonDecode(utf8.decode(response.bodyBytes)).toList();

      return regionList;
    } else {
      throw Exception('Failed to fetch regions');
    }
  }

  Future<List<String>> fetchFrontiers() async {
    final accessToken = userController.accessToken;

    final response = await http.get(
      Uri.parse('http://api.cleanchtraffic.com:5000/api/location/frontier'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json charset=utf-8',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes)).toList();
      final List<String> frontierNames =
          data.map((frontier) => frontier['name'] as String).toList();
      return frontierNames;
    } else {
      throw Exception('Failed to fetch frontiers');
    }
  }

  Future<List<String>> fetchAutoroutes() async {
    final accessToken = userController.accessToken;

    final response = await http.get(
      Uri.parse('http://api.cleanchtraffic.com:5000/api/location/autoroute'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json charset=utf-8',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data =
          jsonDecode(utf8.decode(response.bodyBytes)).toList();

      final List<String> autorouteNames =
          data.map((autoroute) => autoroute['name'] as String).toList();
      return autorouteNames;
    } else {
      throw Exception('Failed to fetch autoroutes');
    }
  }
}
