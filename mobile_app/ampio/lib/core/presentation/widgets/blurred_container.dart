import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors/app_colors.dart';

class BlurredContainer extends StatelessWidget {

  final double? width;
  final double? height;
  final Color? firstColor;
  final Color? secondColor;

  const BlurredContainer({
    super.key,
    this.width,
    this.height,
    this.firstColor,
    this.secondColor
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width ?? 118.w,
      height: height ?? 118.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
             firstColor ?? AppColors.greenAccentPrimary,
             secondColor ?? AppColors.greenAccentSecondary
          ]
        )
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.5, sigmaY: 6.5),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}