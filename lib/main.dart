import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_general_constants.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_theme.dart';
import 'package:pharmacy_warehouse_store_mobile/src/locale/local_controller.dart';
import 'package:pharmacy_warehouse_store_mobile/src/locale/locale.dart';
import 'package:pharmacy_warehouse_store_mobile/src/routes/app_pages.dart';

void main() {
  Get.put(AppLocalController());
  return runApp(ScreenUtilInit(
    designSize: const Size(390, 844),
    minTextAdapt: true,
    splitScreenMode: true,
    useInheritedMediaQuery: true,
    rebuildFactor: (old, data) => true,
    builder: (context, widget) {
      return GetMaterialApp(
        title: kAppTitle,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        defaultTransition: Transition.native,
        transitionDuration: const Duration(seconds: 1),
        translations: AppLocale(),
        locale: const Locale('ar'),
        getPages: AppPages.routes,
        initialRoute: AppPages.INITIAL,
      );
    },
  ));
}

// class PhrarmacyWarehouseStoreMobile extends StatelessWidget {
//   const PhrarmacyWarehouseStoreMobile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(AppLocalController());
//     return GetMaterialApp(
//       title: kAppTitle,
//       debugShowCheckedModeBanner: false,
//       theme: appTheme,
//       defaultTransition: Transition.fadeIn,
//       translations: AppLocale(),
//       locale: Get.deviceLocale,
//       home: const SplashScreen(),
//     );
//   }
// }
