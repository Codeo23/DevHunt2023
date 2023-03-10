import 'package:ampio/core/config/network_config.dart';
import 'package:ampio/core/domain/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../../utils/colors/app_colors.dart';
import '../../../core/utils/constants/route_path.dart';
import 'avatar.dart';

class PostCard extends StatelessWidget {
  final String profileImage;
  final String? name;
  final String? createdAt;
  final String? content;
  final String? topic;
  final Color? color;
  final LinearGradient? gradientColor;
  final UserEntity? user;
  final bool link;

  const PostCard(
      {super.key,
      required this.profileImage,
      required this.name,
      this.createdAt,
      this.content,
      this.topic,
      this.gradientColor,
      this.color,
      this.user,
      this.link = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/response/1'),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.w),
        decoration: BoxDecoration(
            color: color ?? Colors.white,
            borderRadius: BorderRadius.circular(39.r),
            gradient: gradientColor,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(5, 1),
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2.0)
            ]),
        width: 393.w,
        child: Column(
          children: [
            Row(
              children: [
                link
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          '${NetworkConfig.baseUrl}/users/$profileImage',
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Avatar(
                        imageProvider: AssetImage(profileImage),
                        borderRadius: 39.r,
                      ),
                SizedBox(width: 15.w),
                Text(
                  name ?? 'johndoe',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 15.w),
                Text(
                  createdAt ?? '5 min',
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(height: 11.h),
            Text(
              content!,
              style: GoogleFonts.poppins(
                  fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 41.h),
            _buildPostCardFooter()
          ],
        ),
      ),
    );
  }

  Widget _buildPostCardFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(
              Icons.remove_red_eye,
            ),
            SizedBox(width: 6.w),
            Text(
              '5',
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greySecondary),
            ),
          ],
        ),
        SizedBox(width: 100.w),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: AppColors.yellowPrimary,
              shape: RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.circular(35.r))),
          child: Text(
            topic!,
            style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white),
          ),
        )
      ],
    );
  }
}
