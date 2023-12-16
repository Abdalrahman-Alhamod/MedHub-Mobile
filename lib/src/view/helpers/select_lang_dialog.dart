import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Locale/local_controller.dart';

void showSelectLangDialog() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "selectLangauge".tr,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            buildLanguageRadio('en', "english".tr),
            const SizedBox(height: 16.0),
            buildLanguageRadio('ar', "arabic".tr),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
}

Widget buildLanguageRadio(String locale, String label) {
  bool isSelected = Get.locale?.languageCode == locale;

  return RadioListTile(
    title: Text(
      label,
      style: Get.theme.textTheme.titleLarge,
    ),
    value: isSelected,
    groupValue: true,
    onChanged: (value) {
      AppLocalController().changeLang(langCode: locale);
      Get.back();
    },
    fillColor: MaterialStateProperty.all(Colors.lightBlueAccent),
  );
}
