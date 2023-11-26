import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/constants/app_colors.dart';

class CustomeTextField extends StatefulWidget {
  const CustomeTextField({
    super.key,
    required this.obscureText,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    required this.keyboardType,
    required this.prefixIcon,
    this.onTap,
    this.onSubmit,
  });
  final bool obscureText;
  final String hintText;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final void Function()? onTap;
  final void Function(String)? onSubmit;

  @override
  State<CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  bool _enableObscureText = false;
  @override
  void initState() {
    super.initState();
    _enableObscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _enableObscureText,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmit,
      onTapOutside: _handleOnTapOutside,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        labelText: widget.hintText,
        prefixIcon: widget.onTap != null
            ? IconButton(
                onPressed: widget.onTap,
                icon: Icon(widget.prefixIcon),
              )
            : Icon(widget.prefixIcon),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: _enableObscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    _enableObscureText = !_enableObscureText;
                  });
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.primaryColor.withOpacity(.5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
        floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );
  }
}

void _handleOnTapOutside(pointerDownEvent) {
  Get.focusScope!.unfocus();
}
