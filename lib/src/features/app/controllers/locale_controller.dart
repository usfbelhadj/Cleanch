import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Import get_storage

class LocaleController extends GetxController {
  Rx<Locale> currentLocale = Locale('en').obs;

  Future<void> changeLocale(Locale newLocale) async {
    currentLocale.value = newLocale;
    await GetStorage().write('selectedLocale', newLocale.languageCode);
  }

  Future<void> loadSavedLocale() async {
    final selectedLocale = await GetStorage().read('selectedLocale');
    if (selectedLocale != null) {
      currentLocale.value = Locale(selectedLocale);
    }
  }

  String getCurrentLanguageCode() {
    return currentLocale.value.languageCode;
  }
}
