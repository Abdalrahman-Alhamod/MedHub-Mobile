import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryColor,
  hintColor: AppColors.secondaryColor,
  scaffoldBackgroundColor: AppColors.backgroundColor,
  textTheme: const TextTheme(
    displayLarge: AppTextStyles.headline1,
    displayMedium: AppTextStyles.headline2,
    bodyLarge: AppTextStyles.bodyText,
    bodyMedium: AppTextStyles.secondaryText,
  ),
);
