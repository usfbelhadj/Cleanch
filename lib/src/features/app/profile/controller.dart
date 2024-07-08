import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UserInterestsController extends GetxController {
  RxList<String> selectedInterests = <String>[].obs;
  RxList<String> selectedRegInterests = <String>[].obs;
  RxList<String> removedInterests = <String>[].obs;

  final GetStorage storage = GetStorage();

  Future<String> removeInterestRg(List<String> a) async {
    final payload = {
      "valid_locations": [],
      "removed_locations": a,
      "valid_autoroute": [],
      "removed_autoroute": [],
      "valid_frontier": [],
      "removed_frontier": []
    };

    final accessToken = storage.read('accessToken');
    final response = await http.put(
      Uri.parse(
          'http://api.cleanchtraffic.com:5000/api/currentUser/location_preferences/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(payload),
    );

    return response.body;
  }

  Future<String> removeInterestfron(List<dynamic> a) async {
    final payload = {
      "valid_locations": [],
      "removed_locations": [],
      "valid_autoroute": [],
      "removed_autoroute": [],
      "valid_frontier": [],
      "removed_frontier": a
    };

    final accessToken = storage.read('accessToken');
    final response = await http.put(
      Uri.parse(
          'http://api.cleanchtraffic.com:5000/api/currentUser/location_preferences/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(payload),
    );

    return response.body;
  }

  Future<void> removeAut(List<dynamic> a) async {
    final payload = {
      "valid_locations": [],
      "removed_locations": [],
      "valid_autoroute": [],
      "removed_autoroute": a,
      "valid_frontier": [],
      "removed_frontier": []
    };

    final accessToken = storage.read('accessToken');
    final response = await http.put(
      Uri.parse(
          'http://api.cleanchtraffic.com:5000/api/currentUser/location_preferences/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(payload),
    );
  }

  Future<String> addInterestRg(a) async {
    final payload = {
      "valid_locations": a,
      "removed_locations": [],
      "valid_autoroute": [],
      "removed_autoroute": [],
      "valid_frontier": [],
      "removed_frontier": []
    };

    final accessToken = storage.read('accessToken');
    final response = await http.put(
      Uri.parse(
          'http://api.cleanchtraffic.com:5000/api/currentUser/location_preferences/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  Future<String> addInterestFor(a) async {
    List ss = [];

    ss = a;
    final payload = {
      "valid_locations": [],
      "removed_locations": [],
      "valid_autoroute": [],
      "removed_autoroute": [],
      "valid_frontier": ss,
      "removed_frontier": []
    };
    ss = [];
    final accessToken = storage.read('accessToken');
    final response = await http.put(
      Uri.parse(
          'http://api.cleanchtraffic.com:5000/api/currentUser/location_preferences/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  Future<String> addInterestAut(a) async {
    List ss = [];

    ss = a;
    final payload = {
      "valid_locations": [],
      "removed_locations": [],
      "valid_autoroute": ss,
      "removed_autoroute": [],
      "valid_frontier": [],
      "removed_frontier": []
    };
    ss = [];
    final accessToken = storage.read('accessToken');
    final response = await http.put(
      Uri.parse(
          'http://api.cleanchtraffic.com:5000/api/currentUser/location_preferences/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  Future<void> rmRegInterest(List<String> interest) async {
    await removeInterestRg(interest);
  }

  Future<void> rmInterestfron(List<dynamic> interest) async {
    await removeInterestfron(interest);
  }

  Future<void> rmAut(List<dynamic> interest) async {
    await removeAut(interest);
  }

  Future<void> addRegInterest(List<String> interest) async {
    await addInterestRg(interest);
  }
}



 

  // void saveInterests() {
  //   storage.write('selectedInterests', selectedInterests.toList());
  // }

  // void removeInterests() {
  //   storage.write('removedInterests', removedInterests.toList());
  // }

  // void loadInterests() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     final List<dynamic>? interests =
  //         storage.read<List<dynamic>>('selectedInterests');
  //     if (interests != null) {
  //       selectedInterests.assignAll(interests.cast<String>().obs);
  //     }
  //   });
  // }

