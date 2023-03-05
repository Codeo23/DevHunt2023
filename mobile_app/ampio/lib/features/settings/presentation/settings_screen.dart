import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/widgets/blurred_container.dart';
import '../../../../core/utils/colors/app_colors.dart';
import '../../../../features/settings/presentation/widget/setting_item.dart';
import '../../../../core/presentation/widgets/custom_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(5.0),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: 150.h,
                child: BlurredContainer(
                  firstColor: AppColors.greenSecondary,
                  secondColor: AppColors.greenPrimary,
                ),
              ),
              Positioned(
                right: 0,
                bottom: 100.h,
                child: BlurredContainer(
                  firstColor: AppColors.greenSecondary,
                  secondColor: AppColors.greenPrimary,
                  width: 50,
                  height: 50,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => {},
                      icon: Icon(
                        Icons.chevron_left,
                        size: 30.sp,
                      ),
                    ),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/avatar.jpg',
                          height: 150.h,
                          width: 150.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(
                        'Mialy Rak.',
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Compte',
                            style: GoogleFonts.poppins(
                                color: AppColors.greySecondary,
                                fontSize: 16.sp),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SettingItem(
                            icon: Icon(Icons.person),
                            title: 'Profil',
                          ),
                          const SettingItem(
                            icon: Icon(
                              Icons.details,
                              color: Colors.blueAccent,
                            ),
                            title: 'Iformations de votre compte',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Paramètres',
                            style: GoogleFonts.poppins(
                              color: AppColors.greySecondary,
                              fontSize: 16.sp,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SettingItem(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.red,
                            ),
                            title: 'Notification',
                          ),
                          SettingItem(
                            icon: Icon(
                              Icons.warning,
                              color: AppColors.yellowPrimary,
                            ),
                            title: 'Politique de confidentialité',
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          const SettingItem(
                            icon: Icon(Icons.logout),
                            title: 'Déconnecter',
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          CustomButton(
                            backgroundColor: const Color.fromRGBO(174, 215, 252, 1),
                            labelButton: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.question_mark_outlined,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'Aide et feedback',
                                  style:
                                      GoogleFonts.poppins(color: Colors.blue),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
