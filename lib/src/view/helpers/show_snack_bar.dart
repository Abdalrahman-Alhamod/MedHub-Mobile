import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/app_colors.dart';

enum SnackBarMessageType { error, info, success }

void showSnackBar(
  BuildContext context,
  String message,
  SnackBarMessageType messageType,
) {
  Color backgroundColor;
  IconData icon;

  switch (messageType) {
    case SnackBarMessageType.error:
      backgroundColor = Colors.red;
      icon = Icons.error_outline;
      break;
    case SnackBarMessageType.info:
      backgroundColor = AppColors.primaryColor;
      icon = Icons.info_outline;
      break;
    case SnackBarMessageType.success:
      backgroundColor = Colors.green;
      icon = Icons.check_circle_outline;
      break;
  }

  Get.snackbar(
    '',
    '',
    backgroundColor: backgroundColor,
    icon: Icon(
      icon,
      color: Colors.white,
    ),
    titleText: Row(
      children: [
        const SizedBox(width: 8.0),
        Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    ),
    messageText: Container(),
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 6.0,
    margin: const EdgeInsets.all(10.0),
    duration: const Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
    reverseAnimationCurve: Curves.easeInBack,
    showProgressIndicator: false,
    shouldIconPulse: true,
    boxShadows: const [
      BoxShadow(color: Colors.black45, blurRadius: 16.0),
    ],
    mainButton: TextButton(
      onPressed: () => Get.back(),
      child: const Text(
        'Close',
        style: TextStyle(color: Colors.white),
      ),
    ),
    onTap: (snack) {
      // Your action on tap
    },
  );
}
