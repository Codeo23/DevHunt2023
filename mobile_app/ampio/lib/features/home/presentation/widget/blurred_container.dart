import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlurredContainer extends StatelessWidget {

  final double? width;
  final double? height;
  final Color color;

  const BlurredContainer({
    super.key,
    this.width,
    this.height,
    required this.color
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: width ?? 200.w,
      height: height ?? 200.h,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 55.5, sigmaY: 55.5),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    );
  }
}