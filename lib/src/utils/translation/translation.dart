import 'package:get/get.dart';
import 'package:myflutter/src/constants/text_strings_en.dart'; 
import 'package:myflutter/src/constants/text_strings_fr.dart';
import 'package:myflutter/src/constants/text_strings_it.dart'; 
import '../../constants/text_strings_de.dart';
import '../../features/app/controllers/locale_controller.dart'; 

String tr(String key) {
  final LocaleController localeController = Get.find();
  final currentLanguageCode = localeController.getCurrentLanguageCode();

  switch (currentLanguageCode) {
    case 'de':
      return textStringsDe[key] ?? '';
    case 'fr':
      return textStringsFr[key] ?? textStringsEn[key] ?? '';
    case 'it': 
      return textStringsIt[key] ?? textStringsEn[key] ?? '';
    default:
      return textStringsEn[key] ?? '';
  }
}
