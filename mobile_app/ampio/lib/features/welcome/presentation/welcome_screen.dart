import 'package:ampio/features/welcome/presentation/widget/blurred_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/presentation/widgets/gradient_button.dart';
import '../../../core/utils/colors/app_colors.dart';
import '../../../core/utils/constants/route_path.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                top: 19.h,
                left: -54.w,
                child: const BlurredContainer(),
              ),
              Positioned(
                top: 603.h,
                right: -27.33.w,
                child: BlurredContainer(
                  width: 62.92.w,
                  height: 62.92.h,
                ),
              ),
              Positioned(
                bottom: -56.88.h,
                left: -86.w,
                child: BlurredContainer(
                  width: 144.17.w,
                  height: 144.17.h,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 135.h),
                    Image.asset(
                      'assets/logo/ampio2.png',
                      width: 265.w,
                      height: 320.h,
                    ),
                    SizedBox(height: 209.h),
                    Text(
                      'Bienvenue sur l\'application Ampio',
                      style: GoogleFonts.poppins(
                        fontSize: 15.66.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.bluePrimary
                      ),
                    ),
                    SizedBox(height: 14.h),
                    GradientButton(
                      onPressed: () => context.go(RoutePath.loginPath),
                      labelButton: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Commencer',
                            style: GoogleFonts.poppins(
                              fontSize: 15.66.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20.sp,
                          )
                        ],
                      ),
                      gradientColor: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.greenPrimary,
                          AppColors.greenSecondary
                        ]
                      ),
                      width: 339.w,
                      height: 54.h,
                    ),
                  ],
                ),
              ),
            ]
          )
        )
      )
    );
  }
}
