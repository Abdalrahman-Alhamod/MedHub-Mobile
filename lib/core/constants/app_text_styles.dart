import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
   const AppTextStyles._();
  static const TextStyle headline1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle secondaryText = TextStyle(
    fontSize: 14,
    color: AppColors.secondaryTextColor,
  );
}
