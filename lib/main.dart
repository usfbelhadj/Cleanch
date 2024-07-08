import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:myflutter/src/features/app/controllers/locale_controller.dart';
import 'package:myflutter/src/features/authentification/controllers/firebase/firebase_api.dart';
import 'package:myflutter/src/features/app/events/events_page.dart';
import 'package:myflutter/src/features/app/home/home.dart';
import 'package:myflutter/src/features/app/profile/user_profile.dart';
import 'package:myflutter/src/features/authentification/models/user/user_controller.dart';
import 'package:myflutter/src/features/authentification/screens/login/login_screen.dart';
import 'package:myflutter/src/features/authentification/screens/welcome/welcome_screen.dart';
import 'package:myflutter/src/utils/theme/controllers/gradient_theme_controllers.dart';
import 'package:myflutter/src/utils/theme/theme.dart';

import 'src/features/authentification/controllers/check_token.dart';
import 'src/features/authentification/screens/signup/signup_screen.dart';
import 'src/features/authentification/screens/splash_screen/splash_screen.dart';

void main() async {
  final localeController = LocaleController();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final firebaseMessaging = FirebaseMessaging.instance;
  final String? fcmToken = await firebaseMessaging.getToken();
  print('FCM Token: $fcmToken');
  await FirebaseApi().initNotification();
  await FirebaseApi().initMessaging();
  await GetStorage.init();
  await localeController.loadSavedLocale();

  final userController = UserController();
  final box = GetStorage();

  // Retrieve access token if the user is logged in
  final accessToken = box.read('accessToken');
  print('Tokkeenn : $accessToken');

  try {
    var theToken = await checkToken(accessToken);
    print('The Token $theToken');
    box.write('theaccessToken', theToken);
    if (theToken != null) {
      userController.setAccessToken(accessToken);
    }
  } catch (e) {
    print(e);
    userController.logout();
  }

  runApp(
    GetMaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: userController.isLoggedIn.isTrue ? '/auth' : '/home',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/welcome', page: () => WelcomeScreen()),
        GetPage(name: '/auth', page: () => SignUpScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/profile', page: () => UserProfile()),
        GetPage(name: '/events', page: () => EventsPage()),
      ],
      initialBinding: BindingsBuilder(() {
        // Bind the UserController to the app so it can be accessed from anywhere
        Get.put<UserController>(userController);
        Get.put<LocaleController>(localeController);
        Get.put<ThemeController>(ThemeController());
      }),
    ),
  );
}
