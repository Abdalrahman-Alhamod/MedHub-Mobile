import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_general_constants.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_theme.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Locale/local_controller.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Locale/locale.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/start/splash_screen.dart';


void main() {
  return runApp(const PhrarmacyWarehouseStoreMobile());
}

class PhrarmacyWarehouseStoreMobile extends StatelessWidget {
  const PhrarmacyWarehouseStoreMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppLocalController());
    return GetMaterialApp(
      title: kAppTitle,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      defaultTransition: Transition.fadeIn,
      translations: AppLocale(),
      locale: Get.deviceLocale,
      home: const SplashScreen(),
    );
  }
}
