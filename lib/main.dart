import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as get_lib;
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_general_constants.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_theme.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/BottomNavBarCubit/bottom_nav_bar_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/FavourateCubit/favourite_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/ProductsCubit/products_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/locale/local_controller.dart';
import 'package:pharmacy_warehouse_store_mobile/src/locale/locale.dart';
import 'package:pharmacy_warehouse_store_mobile/src/routes/app_pages.dart';
import 'package:pharmacy_warehouse_store_mobile/src/services/simple_bloc_observer.dart';

void main() {
  get_lib.Get.put(AppLocalController());
  Bloc.observer = SimpleBlocObserver();
  return runApp(ScreenUtilInit(
    designSize: const Size(390, 844),
    minTextAdapt: true,
    splitScreenMode: true,
    useInheritedMediaQuery: true,
    rebuildFactor: (old, data) => true,
    builder: (context, widget) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductsCubit(),
          ),
          BlocProvider(
            create: (context) => BottomNavBarCubit(),
          ),
          BlocProvider(
            create: (context) => FavouriteCubit(),
          ),
        ],
        child: get_lib.GetMaterialApp(
          title: kAppTitle,
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          defaultTransition: get_lib.Transition.native,
          transitionDuration: const Duration(seconds: 1),
          translations: AppLocale(),
          locale: const Locale('en'),
          getPages: AppPages.routes,
          initialRoute: AppPages.INITIAL,
        ),
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
