import 'package:ampio/features/home/presentation/widget/search_field.dart';
import 'package:ampio/features/home/presentation/widget/top_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors/app_colors.dart';
import 'widget/blurred_container.dart';

class AllQuestionsScreen extends StatelessWidget {
  const AllQuestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: SizedBox(
              height: double.maxFinite,
              child: Column(children: [
                SizedBox(height: 50.h),
                const Center(child: SearchField()),
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
                SizedBox(height: 12.h),
                const TopQuestions()
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
