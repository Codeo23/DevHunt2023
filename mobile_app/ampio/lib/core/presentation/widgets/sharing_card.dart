import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:google_fonts/google_fonts.dart';

import 'avatar.dart';

class SharingCard extends StatelessWidget {

  final String profileImage;
  final String name;
  final String? content;
  final String image;
  final Color? color;
  final LinearGradient? gradientColor;
  final String sharedSubject;

  const SharingCard({
    super.key,
    required this.profileImage,
    required this.name,
    this.content,
    this.gradientColor,
    required this.image,
    required this.sharedSubject,
    this.color
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 11.w
      ),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(39.r),
        gradient: gradientColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(5, 1),
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2.0
          )
        ]
      ),
      width: 393.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(
                imageProvider: AssetImage(profileImage),
                borderRadius: 30.r,
              ),
              SizedBox(width: 15.w),
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
              SizedBox(width: 15.w),
            ],
          ),
          SizedBox(height: 11.h),
          Text(
            content!,
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white
            ),
          ),
          SizedBox(height: 41.h),
          _buildSharingSubject()
        ],
      ),
    );
  }

  Widget _buildSharingSubject() {

    return GlassContainer(
      width: 353.w,
      height: 66.h,
      blur: 2,
      color: Colors.white.withOpacity(0.1),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.1),
          Colors.blue.withOpacity(0.5),
        ],
      ),
      //--code to remove border
      shadowStrength: 5,
      borderRadius: BorderRadius.circular(16),
      shadowColor: Colors.white.withOpacity(0.24),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 9.w,
          vertical: 10.h
        ),
        child: Row(
          children: [
            Row(
              children: [
                Image.asset(
                  image,
                  width: 45.w,
                  height: 45.w,
                ),
                SizedBox(width: 18.w),
                Text(
                  sharedSubject,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward, color: Colors.white, size: 17.sp)
          ],
        ),
      ),
    );
  }
}