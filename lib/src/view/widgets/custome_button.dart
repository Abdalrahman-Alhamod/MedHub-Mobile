import 'package:flutter/material.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';

class CustomeButton extends StatelessWidget {
  const CustomeButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.width,
      this.height,
      this.isEnabled = true});
  final String title;
  final double? width, height;
  final void Function() onTap;
  final bool isEnabled;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: isEnabled ? AppColors.primaryColor : Colors.grey,
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
