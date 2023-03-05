import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget labelButton;
  final double width;
  final double height;
  final Color? backgroundColor;
  final double? borderRadius;
  final void Function()? onPressed;
  final bool borderSide;

  const CustomButton({
    super.key,
    required this.labelButton,
    this.onPressed,
    this.height = 45,
    this.width = double.infinity,
    this.borderRadius,
    this.backgroundColor,
    this.borderSide = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // TODO : change Redirection in home page
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0.0,
          fixedSize: Size(width, height),
          backgroundColor: backgroundColor ?? AppColors.greenPrimary,
          shape: RoundedRectangleBorder(
            side: borderSide
                ? const BorderSide(width: 1.0, color: Colors.white)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
          )),
      child: labelButton,
    );
  }
}
