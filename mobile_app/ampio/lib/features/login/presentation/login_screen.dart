import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/colors/app_colors.dart';
import '../../../features/login/presentation/widget/build_form_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.greenSecondary, AppColors.greenPrimary]),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/logo/logo2.png',
                          width: 50.w,
                          fit: BoxFit.fill,
                        ),
                        Row(
                          children: [
                            Text(
                              'VOUS N\'AVEZ PAS UN COMPTE?',
                              style: GoogleFonts.poppins(
                                  color: const Color.fromRGBO(176, 255, 239, 1),
                                  fontSize: 12.sp),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'S\'INSCRIRE',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            )
                          ],
                        ),
                      ],
                    )),
                Image.asset(
                  'assets/logo/confution_decision.png',
                  height: 160.h,
                  width: 318.w,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'SE CONNECTER',
                        style: GoogleFonts.poppins(
                            fontSize: 40.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Veuillez insérer votre identité et',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'mot de passe',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      const BuildFormLogin(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
