import 'package:flutter/material.dart';
import 'package:pharmacy_warehouse_store_mobile/core/app_colors.dart';

class CustomeTextField extends StatefulWidget {
  const CustomeTextField(
      {super.key,
      required this.obscureText,
      required this.hintText,
      required this.onChanged,
      required this.validator,
      required this.keyboardType,
      required this.prefixIcon});
  final bool obscureText;
  final String hintText;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final IconData? prefixIcon;

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        obscureText: _enableObscureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        onChanged: widget.onChanged,
        cursorColor: AppColors.primaryColor,
        decoration: InputDecoration(
          labelText: widget.hintText,
          prefixIcon: Icon(widget.prefixIcon),
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
            borderSide: BorderSide(
              color: AppColors.primaryColor.withOpacity(.5),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
      ),
    );
  }
}
