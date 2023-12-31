import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/src/routes/app_routes.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/auth/login_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/auth/register_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/drawer/profile_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/drawer/statistics_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation%20bar/home_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/order_details_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/product_details_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/start/splash_screen.dart';

class AppPages {
  const AppPages._();
  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;
  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => const SplashScreen()),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen()),
    GetPage(name: Routes.REGISTER, page: () => RegisterScreen()),
    GetPage(name: Routes.HOME, page: () => const HomeScreen()),
    GetPage(
      name: Routes.PRODUCT_DETAILS,
      page: () => ProductDetailsScreen(),
    ),
    GetPage(name: Routes.PROFILE, page: () => const ProfileScreen()),
    GetPage(name: Routes.STATISTICS, page: () => const StatisticsScreen()),
    GetPage(name: Routes.ORDER_DETAILS, page: () => const OrderDetailsScreen()),
  ];
}
