import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  final _storage = GetStorage();

  RxBool isLoggedIn = false.obs;
  Rx<Map> userData = Rx<Map>({}.obs);
  RxString accessToken = RxString('');

  UserController() {
    // Retrieve user data from storage during initialization
    final storedUserData = _storage.read('userData');
    if (storedUserData != null) {
      userData.value = Map<String, dynamic>.from(storedUserData);
      isLoggedIn.value = true;
    }
  }

  void setUserLoggedIn(bool value) {
    isLoggedIn.value = value;
    // Save the logged-in state to storage
    _storage.write('isLoggedIn', value);
  }

  void setUserData(Map<String, dynamic> data) {
    userData.value = data;
    isLoggedIn.value = true;
    // Save user data to storage
    _storage.write('userData', data);
  }

  void setAccessToken(String token) {
    accessToken.value = token;
  }

  void logout() {
    isLoggedIn.value = false;
    userData.value = {};
    accessToken.value = ''; // Clear the access token
    _storage.remove('isLoggedIn');
    _storage.remove('userData');
    _storage.remove('accessToken');
    // remove fcm

    // Optionally, navigate to the welcome screen or any other desired screen
    Get.offAllNamed('/welcome');
  }
}
