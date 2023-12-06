import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_icons.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/Cubits/Auth/Register/register_cubit.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_loading_dialog.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/auth/login_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation%20bar/home_screen.dart';

import '../../widgets/custome_button.dart';
import '../../widgets/custome_text_field.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  // ignore: unused_field
  static String? pharmacyName, userName, phoneNumber, password, confirmPassword;

  final formKey = GlobalKey<FormState>();

  String? Function(String?) pharmacyNameValidator = (value) {
    if (value!.isEmpty) {
      return "fieldIsRequired".tr;
    } else {
      return null;
    }
  };
  String? Function(String?) userNameValidator = (value) {
    if (value!.isEmpty) {
      return "fieldIsRequired".tr;
    } else {
      return null;
    }
  };

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
  String? Function(String?) confirmPasswordValidator = (value) {
    if (value!.isEmpty) {
      return "fieldIsRequired".tr;
    } else if (value.length < 8) {
      return "passwordShouldBe8".tr;
    } else if (password != confirmPassword) {
      return "passwordsDontMatch".tr;
    } else {
      return null;
    }
  };

  @override
  Widget build(BuildContext context) {
    void registerUser() async {
      if (formKey.currentState!.validate()) {
        BlocProvider.of<RegisterCubit>(context).registerWithPhoneNumber(
            userName: userName!,
            pharmacyName: pharmacyName!,
            phoneNumber: phoneNumber!,
            password: password!);
      }
    }

    void loginPage() {
      Get.off(() => LoginScreen());
    }

    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          showLoadingDialog();
        } else if (state is RegisterSuccess) {
          Get.until((route) => !Get.isDialogOpen!);
          showSnackBar("registerSuccess".tr, SnackBarMessageType.success);
          Get.off(() => const HomeScreen());
        } else if (state is RegisterFailure) {
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
                          AppIcons.register,
                          size: 100,
                          color: AppColors.primaryColor,
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "letsCreateAnAccount".tr,
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
                          validator: pharmacyNameValidator,
                          obscureText: false,
                          hintText: "pharmacyName".tr,
                          onChanged: (text) {
                            pharmacyName = text;
                            formKey.currentState!.validate();
                          },
                          keyboardType: TextInputType.name,
                          prefixIcon: AppIcons.pharmacy,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomeTextField(
                          validator: userNameValidator,
                          obscureText: false,
                          hintText: "userName".tr,
                          onChanged: (text) {
                            userName = text;
                            formKey.currentState!.validate();
                          },
                          keyboardType: TextInputType.name,
                          prefixIcon: AppIcons.person,
                        ),
                        const SizedBox(
                          height: 10,
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
                        const SizedBox(
                          height: 10,
                        ),
                        CustomeTextField(
                          validator: confirmPasswordValidator,
                          obscureText: true,
                          hintText: "confirmPassword".tr,
                          onChanged: (text) {
                            confirmPassword = text;
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
                          title: "signUp".tr,
                          onTap: registerUser,
                          height: 70.h,
                          width: 340.w,
                        ),

                        // not a member> register now
                        SizedBox(
                          height: 75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "alreadyHaveAnAccount".tr,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor),
                              ),
                              GestureDetector(
                                onTap: loginPage,
                                child: Text(
                                  "signIn".tr,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.secondaryColor),
                                ),
                              ),
                            ],
                          ),
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
