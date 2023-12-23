import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomIconButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return SizedBox(
      width: width ?? 44.w,
      height: height ?? 44.h,
      child: Material(
        color: backgroundColor ?? theme.colorScheme.background,
        shape: borderColor == null
            ? const CircleBorder()
            : CircleBorder(
                side: BorderSide(color: borderColor!),
              ),
        child: InkWell(
          onTap: onPressed,
          highlightColor: theme.primaryColor.withOpacity(0.2),
          customBorder: const CircleBorder(),
          child: icon,
        ),
      ),
    );
  }
}
