import 'package:flutter/material.dart';
import 'package:pharmacy_warehouse_store_mobile/Constants/app_general_constants.dart';
import 'package:pharmacy_warehouse_store_mobile/pages/login_page.dart';
import 'package:pharmacy_warehouse_store_mobile/pages/register_page.dart';
import 'package:pharmacy_warehouse_store_mobile/pages/splash_screen.dart';

void main() {
  return runApp(const PhrarmacyWarehouseStoreMobile());
}

class PhrarmacyWarehouseStoreMobile extends StatelessWidget {
  const PhrarmacyWarehouseStoreMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      debugShowCheckedModeBanner: false,
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        SplashScreen.id: (context) => const SplashScreen(),
      },
      initialRoute: SplashScreen.id,
    );
  }
}
