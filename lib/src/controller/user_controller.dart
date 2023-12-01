import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/user.dart';
import 'package:pharmacy_warehouse_store_mobile/src/services/api.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/helpers/show_snack_bar.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/auth/login_screen.dart';
import 'package:pharmacy_warehouse_store_mobile/src/view/screens/navigation%20bar/home_screen.dart';

import '../view/helpers/show_loading_dialog.dart';

class UserController {
  void signInWithPhoneNumberAndPassword(
      {required String phoneNumber, required String password}) async {
    try {
      showLoadingDialog();
      // await Api().request(
      //   url: '/login',
      //   body: {
      //     'phoneNumber': phoneNumber,
      //     'password': password,
      //   },
      //   token: User.token,
      //   methodType: MethodType.post,
      // );
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
      showSnackBar("signedInSuccess".tr, SnackBarMessageType.success);
      Get.off(() => const HomeScreen());
    } on DioException catch (e) {
      Get.back();
      showSnackBar(e.message.toString(), SnackBarMessageType.error);
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), SnackBarMessageType.error);
    }
  }

  void registerWithPhoneNumber(
      {required String userName,
      required String pharmacyName,
      required String phoneNumber,
      required String password}) async {
    try {
      showLoadingDialog();
      // await Api().request(
      //   url: '/register',
      //   body: {
      //     'name': userName,
      //     'pharmacyName': pharmacyName,
      //     'phoneNumber': phoneNumber,
      //     'password': password,
      //   },
      //   token: User.token,
      //   methodType: MethodType.post,
      // );
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
      showSnackBar("registerSuccess".tr, SnackBarMessageType.success);
      //Get.off(() => const HomeScreen());
    } on DioException catch (e) {
      Get.back();
      showSnackBar(e.message.toString(), SnackBarMessageType.error);
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), SnackBarMessageType.error);
    }
  }

  void logout() async {
    try {
      log(Get.locale.toString());
      showLoadingDialog();
      // await Api().request(
      //   url: '/logout',
      //   // TODO remove from body when implement header
      //   body: {'token': User.token},
      //   token: User.token,
      //   methodType: MethodType.post,
      // );
      await Future.delayed(const Duration(seconds: 2));
      Get.back();
      showSnackBar("logedOutSuccess".tr, SnackBarMessageType.success);
      Get.off(() => const LoginScreen());
    } on DioException catch (e) {
      Get.back();
      showSnackBar(e.message.toString(), SnackBarMessageType.error);
      log(e.error.toString());
    } catch (e) {
      Get.back();
      showSnackBar(e.toString(), SnackBarMessageType.error);
      log(e.toString());
    }
  }
}
