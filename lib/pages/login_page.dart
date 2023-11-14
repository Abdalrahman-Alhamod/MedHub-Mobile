import 'package:flutter/material.dart';
import 'package:pharmacy_warehouse_store_mobile/Constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/Constants/app_icons.dart';
import 'package:pharmacy_warehouse_store_mobile/Constants/app_images.dart';
import 'package:pharmacy_warehouse_store_mobile/pages/register_page.dart';

import '../components/custome_button.dart';
import '../components/custome_text_field.dart';
import '../helpers/show_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ignore: unused_field
  static String? userNumber, password;

  final formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    void signInUser() async {
      if (formKey.currentState!.validate()) {
        showSnackBar(
            context, 'Logged in Successfully!', SnackBarMessageType.success);
      }
    }

    void registerUserPage() {
      Navigator.pushReplacementNamed(context, RegisterPage.id);
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
                    const Text(
                      'Welcome back',
                      style: TextStyle(
                          fontSize: 24,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Please enter your credentials to Login',
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

                    // sign in button
                    const SizedBox(
                      height: 30,
                    ),
                    CustomeButton(title: 'Sign in', onTap: signInUser),

                    // not a member> register now
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Not a member? ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor),
                        ),
                        GestureDetector(
                          onTap: registerUserPage,
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.hintColor),
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
