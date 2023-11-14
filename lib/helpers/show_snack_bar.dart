import 'package:flutter/material.dart';
import 'package:pharmacy_warehouse_store_mobile/Constants/app_colors.dart';

enum SnackBarMessageType { error, info, success }

void showSnackBar(
    BuildContext context, String message, SnackBarMessageType messageType) {
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
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor, // Background color
      elevation: 6.0, // Elevation for a shadow
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white, // Icon color
          ),
          const SizedBox(width: 8.0),
          Text(
            message,
            style: const TextStyle(
              color: Colors.white, // Text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white, // Action text color
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}
