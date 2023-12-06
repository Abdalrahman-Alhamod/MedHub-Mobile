import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_icons.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Auth/Login/login_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_loading_dialog.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/auth/register_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation%20bar/home_screen.dart';

import '../../widgets/custome_button.dart';
import '../../widgets/custome_text_field.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  // ignore: unused_field
  static String? phoneNumber, password;

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
        BlocProvider.of<LoginCubit>(context).signInWithPhoneNumberAndPassword(
            phoneNumber: phoneNumber!, password: password!);
      }
    }

    void registerUserPage() {
      Get.off(() => RegisterScreen());
    }

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showLoadingDialog();
        } else if (state is LoginSuccess) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar("signedInSuccess".tr, SnackBarMessageType.success);
          Get.off(() => const HomeScreen());
        } else if (state is LoginFailure) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar(state.errorMessage, SnackBarMessageType.error);
        }
      },
      child: Scaffold(
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
                child: SizedBox(
                  width: 360,
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
                            phoneNumber = text;
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
                          height: 70.h,
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
        ),
      ),
    );
  }
}
