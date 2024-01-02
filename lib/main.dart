import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' as get_lib;
import 'package:logger/logger.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_general_constants.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_theme.dart';
import 'package:pharmacy_warehouse_store_mobile/firebase_options.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Auth/Login/login_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Auth/Logout/logout_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Auth/Register/register_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/BottomNavBar/bottom_nav_bar_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Cart/cart_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Category/category_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Favourite/favourite_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Home/home_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Orders/orders_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Products/products_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Report/report_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Statistics/statistics_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/User/user_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/locale/local_controller.dart';
import 'package:pharmacy_warehouse_store_mobile/src/locale/locale.dart';
import 'package:pharmacy_warehouse_store_mobile/src/routes/app_pages.dart';
import 'package:pharmacy_warehouse_store_mobile/src/services/firebase_api.dart';
import 'package:pharmacy_warehouse_store_mobile/src/services/simple_bloc_observer.dart';

Logger logger = Logger(printer: PrettyPrinter(printEmojis: false));
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();

  get_lib.Get.put(AppLocalController());
  Bloc.observer = SimpleBlocObserver();

  return runApp(
    ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => false,
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
            BlocProvider(
              create: (context) => CartCubit(),
            ),
            BlocProvider(
              create: (context) => CategoryCubit(),
            ),
            BlocProvider(
              create: (context) => HomeCubit(),
            ),
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
            BlocProvider(
              create: (context) => RegisterCubit(),
            ),
            BlocProvider(
              create: (context) => LogoutCubit(),
            ),
            BlocProvider(
              create: (context) => OrdersCubit(),
            ),
            BlocProvider(
              create: (context) => UserCubit(),
            ),
            BlocProvider(
              create: (context) => StatisticsCubit(),
            ),
            BlocProvider(
              create: (context) => ReportCubit(),
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
            localizationsDelegates: const [
              GlobalMaterialLocalizations
                  .delegate, // Standard material localizations
              MonthYearPickerLocalizations
                  .delegate, // Custom month-year picker localizations
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            getPages: AppPages.routes,
            initialRoute: AppPages.INITIAL,
          ),
        );
      },
    ),
  );
}
