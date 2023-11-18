import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/core/app_icons.dart';
import 'package:pharmacy_warehouse_store_mobile/core/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/login_page.dart';

import '../widgets/custome_button.dart';
import '../widgets/custome_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const route = '/RegisterPage';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // ignore: unused_field
  static String? pharmacyName, userName, userNumber, password, confirmPassword;

  final formKey = GlobalKey<FormState>();

  String? Function(String?) pharmacyNameValidator = (value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else {
      return null;
    }
  };
  String? Function(String?) userNameValidator = (value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else {
      return null;
    }
  };

  String? Function(String?) userNumberValidator = (value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else if (value.length >= 2 && value.substring(0, 2) != '09') {
      return 'Phone number should start with "09"';
    } else if (value.length < 10 || value.length > 10) {
      return 'Phone number should be 10 digits';
    } else if (int.tryParse(value) == null) {
      return 'Please enter a valid number';
    } else {
      return null;
    }
  };

  String? Function(String?) passwordValidator = (value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else if (value.length < 8) {
      return 'Password should be at least 8 characters';
    } else {
      return null;
    }
  };
  String? Function(String?) confirmPasswordValidator = (value) {
    if (value!.isEmpty) {
      return 'Field is required';
    } else if (value.length < 8) {
      return 'Password should be at least 8 characters';
    } else if (password != confirmPassword) {
      return 'Passwords don\'t match';
    } else {
      return null;
    }
  };

  @override
  Widget build(BuildContext context) {
    void registerUser() async {
      if (formKey.currentState!.validate()) {
        showSnackBar(
            context, 'Signed up Successfully!', SnackBarMessageType.success);
      }
    }

    void loginPage() {
      Get.off(const LoginPage());
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
                      AppIcons.register,
                      size: 100,
                      color: AppColors.primaryColor,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Let\'s Create an account for you',
                      style: TextStyle(
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
                      hintText: 'Pharmacy Name',
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
                      hintText: 'User Name',
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
                      hintText: 'User Number',
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
                      hintText: 'Password',
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
                      hintText: 'Confirm Password',
                      onChanged: (text) {
                        confirmPassword = text;
                        formKey.currentState!.validate();
                      },
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: AppIcons.password,
                    ),

                    // sign in button
                    const SizedBox(
                      height: 30,
                    ),
                    CustomeButton(title: 'Sign up', onTap: registerUser),

                    // not a member> register now
                    SizedBox(
                      height: 75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textColor),
                          ),
                          GestureDetector(
                            onTap: loginPage,
                            child: const Text(
                              'Login',
                              style: TextStyle(
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
    );
  }
}
