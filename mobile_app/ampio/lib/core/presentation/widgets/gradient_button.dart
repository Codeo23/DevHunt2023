import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_button.dart';

@immutable
class GradientButton extends CustomButton {

  final LinearGradient gradientColor;
  final double verticalMargin;
  final double horizontalMargin;

  const GradientButton({
    super.key,
    required super.labelButton,
    required this.gradientColor,
    super.onPressed,
    super.backgroundColor = Colors.transparent,
    super.borderRadius,
    super.width,
    super.height,
    this.verticalMargin = 0.0,
    this.horizontalMargin = 0.0,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: verticalMargin,
        horizontal: horizontalMargin
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(super.borderRadius ?? 6.0.r),
          gradient: gradientColor
      ),
      child: super.build(context)
    );
  }
}