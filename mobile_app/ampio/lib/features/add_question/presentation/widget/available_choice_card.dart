import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../../core/utils/colors/app_colors.dart';

class AvailableChoiceCard extends StatelessWidget {

  final String image;
  final String title;
  final String? description;

  const AvailableChoiceCard({
    Key? key,
    required this.image,
    required this.title,
   this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SimpleShadow(
      opacity: 0.25,
      sigma: 12,
      color: Colors.black,
      offset: const Offset(15, 15),
      child: Container(
        width: 170.w,
        height: 170.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: const Color.fromRGBO(238, 238, 238, 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SimpleShadow(
              sigma: 12,
              opacity: 0.25,
              offset: const Offset(21, 15),
              child: Image.asset(
                image,
                width: 91.w,
                height: 93.w,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              description ?? '',
              style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey
              ),
            ),
          ],
        ),
      ),
    );
  }
}