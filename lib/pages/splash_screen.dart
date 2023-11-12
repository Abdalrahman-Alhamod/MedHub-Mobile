import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_warehouse_store_mobile/Constants/app_animations.dart';
import 'package:pharmacy_warehouse_store_mobile/Constants/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const id = 'Splash Screen';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, LoginPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return const Splash();
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              AppImages.startWallpaper), // Replace with your image asset
          fit: BoxFit.cover,
        ),
      ),
      child: Center(child: Lottie.asset(AppAnimations.startAnimation)),
    );
  }
}
