import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppDecorations {

  const AppDecorations._();
  static const BoxDecoration primaryButtonDecoration = BoxDecoration(
    color: AppColors.primaryColor,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const BoxDecoration secondaryButtonDecoration = BoxDecoration(
    color: AppColors.secondaryColor,
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.backgroundColor,
    borderRadius: const BorderRadius.all(Radius.circular(8)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
