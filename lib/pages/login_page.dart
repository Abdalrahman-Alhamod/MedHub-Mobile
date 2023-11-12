import 'package:flutter/material.dart';
import 'package:pharmacy_warehouse_store_mobile/Constants/app_colors.dart';
import 'package:pharmacy_warehouse_store_mobile/Constants/app_icons.dart';

import '../components/custome_button.dart';
import '../components/custome_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const id = 'LoginPage';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static String? userNumber, password;

  final formKey = GlobalKey<FormState>();

  String? Function(String?) emailValidator = (value) {
    if (value!.isEmpty) {
      return 'Field is required';
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
    void signInUser() async {}
    void forgotPassword() {}
    void signInWithGoogle() {}
    void signInWithFacebook() {}
    void registerUserPage() {}

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
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
                    'Welcome back, you have been missed!',
                    style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textColor,
                        fontWeight: FontWeight.bold),
                  ),

                  // user email textfield
                  const SizedBox(
                    height: 25,
                  ),
                  CustomeTextField(
                    validator: emailValidator,
                    obscureText: false,
                    hintText: 'User Number',
                    onChanged: (text) {
                      userNumber = text;
                      formKey.currentState!.validate();
                    },
                    keyboardType: TextInputType.phone,
                    prefixIcon: AppIcons.phone,
                    suffixIcon: null,
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
                    suffixIcon: null,
                  ),

                  // sign in button
                  const SizedBox(
                    height: 40,
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
    );
  }
}
