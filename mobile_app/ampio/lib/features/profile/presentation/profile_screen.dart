import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/utils/colors/app_colors.dart';
import '../../../../features/profile/presentation/widget/questions.dart';
import '../../../../features/profile/presentation/widget/responses.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        const Color.fromRGBO(8, 80, 90, 1),
        AppColors.greenSecondary
      ])),
      child: SafeArea(
        child: Column(
          children: [
            const Icon(Icons.menu),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/avatar.jpg',
                    height: 150.h,
                    width: 150.h,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Mialy Rak.',
                  style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.greyPrimary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Colors.black,
                        indicatorColor: AppColors.orangePrimary,
                        indicatorWeight: 4,
                        tabs: const [
                          Tab(
                            text: 'Mes questions',
                          ),
                          Tab(
                            text: 'Mes réponses',
                          ),
                        ],
                      ),
                      const Expanded(
                        child: TabBarView(children: [Questions(), Responses()]),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
