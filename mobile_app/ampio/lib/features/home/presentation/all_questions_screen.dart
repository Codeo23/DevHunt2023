import 'package:ampio/features/home/presentation/widget/chip_list.dart';
import 'package:ampio/features/home/presentation/widget/search_field.dart';
import 'package:ampio/features/home/presentation/widget/top_questions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors/app_colors.dart';
import 'widget/blurred_container.dart';

class AllQuestionsScreen extends StatelessWidget {
  const AllQuestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  SizedBox(height: 40.h,),
                  const Center(child: SearchField()),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon : Icon(Icons.chevron_left,size: 30,)
                      ),
                      Text(
                        'QUESTIONS',
                        style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                const TopQuestions()
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
