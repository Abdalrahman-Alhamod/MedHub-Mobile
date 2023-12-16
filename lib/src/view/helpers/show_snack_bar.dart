import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum SnackBarMessageType { error, info, success, notification }

void showSnackBar(
  String message,
  SnackBarMessageType messageType, {
  void Function(GetSnackBar)? onTap,
}) {
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
    case SnackBarMessageType.notification:
      backgroundColor = AppColors.primaryColor;
      icon = Icons.notifications_active;
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
    titleText: const SizedBox(
      width: 0,
      height: 0,
    ),
    messageText: Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 8.0),
          Expanded(
            child: AutoSizeText(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    ),
    snackPosition: SnackPosition.TOP,
    borderRadius: 6.0,
    margin: const EdgeInsets.all(10.0),
    duration: const Duration(seconds: 4),
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
      child: Text(
        "close".tr,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    onTap: onTap,
  );
}
