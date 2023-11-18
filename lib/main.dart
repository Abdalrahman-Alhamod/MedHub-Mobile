import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/app_general_constants.dart';
import 'package:pharmacy_warehouse_store_mobile/core/app_theme.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/splash_screen.dart';

void main() {
  return runApp(const PhrarmacyWarehouseStoreMobile());
}

class PhrarmacyWarehouseStoreMobile extends StatelessWidget {
  const PhrarmacyWarehouseStoreMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: kAppTitle,
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      defaultTransition: Transition.fadeIn,
      home: const SplashScreen(),
    );
  }
}
