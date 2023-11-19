import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppLocalController extends GetxController {
  void changeLang({required String langCode}) {
    Get.updateLocale(Locale(langCode));
  }
}
