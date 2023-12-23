import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';

class CustomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget icon;
  final Color titleColor;
  const CustomeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.titleColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 10.w, 12.h),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        children: [
          icon,
          8.horizontalSpace,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: AutoSizeText(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: titleColor,
                  ),
                  minFontSize: 6,
                  wrapWords: false,
                  maxLines: 2,
                ),
              ),
              2.verticalSpace,
              SizedBox(
                  width: 100,
                  child: AutoSizeText(
                    subtitle,
                    style: theme.textTheme.bodyMedium,
                    minFontSize: 6,
                    maxLines: 1,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
