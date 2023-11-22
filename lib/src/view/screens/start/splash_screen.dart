import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_animations.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
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
    Get.off(() => const LoginScreen());
  }

  @override
  void didChangeDependencies() {
    precacheImage(const AssetImage(AppImages.startWallpaper), context);
    super.didChangeDependencies();
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
    return Scaffold(
      body: Center(child: Lottie.asset(AppAnimations.startAnimation)),
    );
  }
}
