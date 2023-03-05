import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/widgets/gradient_button.dart';
import '../../../../core/utils/colors/app_colors.dart';
import '../../../../features/profile/presentation/widget/share_item.dart';
import '../../../../features/share_post/presentation/share_post_screen.dart';


class Shares extends StatelessWidget {
  const Shares({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: ListView(
        children: [
          GradientButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => const SharePostScreen(),
            ),
            height: 50,
            labelButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Partager',
                  style:
                      GoogleFonts.poppins(fontSize: 20.sp, color: Colors.white),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
            gradientColor: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.greenPrimary,
                AppColors.greenSecondary
              ],
            ),
            width: double.infinity,
          ),
          ShareItem(),
          ShareItem(),
          ShareItem(),
          ShareItem(),
          ShareItem(),
          ShareItem(),
          ShareItem(),
        ],
      ),
    );
  }
}
