import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_icons.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/services/api.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation%20bar/home_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/auth/register_screen.dart';

import '../../widgets/custome_button.dart';
import '../../widgets/custome_text_field.dart';
import '../../helpers/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: unused_field
  static String? userNumber, password;

  final formKey = GlobalKey<FormState>();

  String? Function(String?) userNumberValidator = (value) {
    if (value!.isEmpty) {
      return "fieldIsRequired".tr;
    } else if (value.length >= 2 && value.substring(0, 2) != '09') {
      return "phoneNumberShouldStart".tr;
    } else if (value.length < 10 || value.length > 10) {
      return "phoneNumberLength".tr;
    } else if (int.tryParse(value) == null) {
      return "enterValidNumber".tr;
    } else {
      return null;
    }
  };

  String? Function(String?) passwordValidator = (value) {
    if (value!.isEmpty) {
      return "fieldIsRequired".tr;
    } else if (value.length < 8) {
      return "passwordShouldBe8".tr;
    } else {
      return null;
    }
  };

  @override
  Widget build(BuildContext context) {
    void signInUser() async {
      if (formKey.currentState!.validate()) {
        try {
          showSnackBar(
              context, "signedInSuccess".tr, SnackBarMessageType.success);
          Get.off(() => const HomeScreen());
        } catch (e) {
          log(e.toString());
        }
      }
    }

    void registerUserPage() {
      Get.off(() => const RegisterScreen());
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                AppImages.startWallpaper), // Replace with your image asset
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    const Icon(
                      AppIcons.lock,
                      size: 100,
                      color: AppColors.primaryColor,
                    ),

                    // Welcome message
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "welcomeMessage".tr,
                      style: const TextStyle(
                          fontSize: 24,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "enterCredentials".tr,
                      style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.secondaryTextColor,
                          fontWeight: FontWeight.bold),
                    ),

                    // user email textfield
                    const SizedBox(
                      height: 25,
                    ),
                    CustomeTextField(
                      validator: userNumberValidator,
                      obscureText: false,
                      hintText: "userNumber".tr,
                      onChanged: (text) {
                        userNumber = text;
                        formKey.currentState!.validate();
                      },
                      keyboardType: TextInputType.phone,
                      prefixIcon: AppIcons.phone,
                    ),

                    // password textfield
                    const SizedBox(
                      height: 10,
                    ),
                    CustomeTextField(
                      validator: passwordValidator,
                      obscureText: true,
                      hintText: "password".tr,
                      onChanged: (text) {
                        password = text;
                        formKey.currentState!.validate();
                      },
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: AppIcons.password,
                    ),

                    // sign in button
                    const SizedBox(
                      height: 20,
                    ),
                    CustomeButton(
                      title: "signIn".tr,
                      onTap: signInUser,
                      height: 80.h,
                      width: 340.w,
                    ),

                    // not a member> register now
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "notAMember".tr,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor),
                        ),
                        GestureDetector(
                          onTap: registerUserPage,
                          child: Text(
                            "register".tr,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondaryColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
