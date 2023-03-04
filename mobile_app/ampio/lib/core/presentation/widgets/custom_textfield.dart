import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? textInputType;
  final bool obscureText;
  final Icon? prefixIcon;
  final String? prefixText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final double borderRadius;
  final TextEditingController? controller;
  final Function()? onTapShowPassword;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.textInputType,
    this.prefixIcon,
    this.prefixText,
    this.obscureText = false,
    this.fillColor,
    this.hintStyle,
    this.onTapShowPassword,
    this.borderRadius = 6.0,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(color: Colors.white, fontSize: 14.sp),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        filled: true,
        fillColor: fillColor ?? AppColors.greenSecondary.withOpacity(0.5),
        prefixIcon: prefixIcon,
        suffixIcon: textInputType == TextInputType.visiblePassword
            ? _buildSuffixIconPassword(obscureText, onTapShowPassword)
            : null,
      ),
    );
  }

  Widget _buildSuffixIconPassword(
    bool obscureText,
    Function()? onTapShowPassword,
  ) {
    return IconButton(
      onPressed: onTapShowPassword,
      icon: Icon(obscureText
          ? Icons.visibility_outlined
          : Icons.visibility_off_outlined),
    );
  }
}
