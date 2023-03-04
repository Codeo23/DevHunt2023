import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/colors/app_colors.dart';
import 'widget/blurred_container.dart';
import 'widget/chip_list.dart';
import 'widget/search_field.dart';
import 'widget/sharing_lists.dart';
import 'widget/top_questions.dart';
import 'widget/topic_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.greyThirdly,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: -25.0,
              top: -25.0,
              child: BlurredContainer(
                color: AppColors.greenSecondary,
              ),
            ),
            Positioned(
              left: -38.w,
              top: 588.h,
              child: BlurredContainer(
                color: AppColors.pinkPrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70.h),
                    const Center(child: SearchField()),
                    SizedBox(height: 17.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOPIQUES',
                          style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Voir tout',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 89.h, child: const TopicList()),
                    SizedBox(height: 22.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Questions',
                          style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Voir tout',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 45.h, child: const ChipList()),
                    SizedBox(height: 12.h),
                    const TopQuestions(),
                    SizedBox(height: 22.h),
                    Text(
                      'PARTAGE',
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(height: 12.h),
                    const SharingLists(),
                    SizedBox(height: 15.h),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}