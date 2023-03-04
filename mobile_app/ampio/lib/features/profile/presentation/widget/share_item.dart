import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/widgets/custom_textfield.dart';
import '../../../../core/utils/colors/app_colors.dart';

class ShareItem extends StatelessWidget {
  const ShareItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Meilleure site de templates',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CustomTextField(
            hintText: 'https://dibbble.com',
            fillColor: AppColors.greyPrimary,
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey,
              fontSize: 14.sp
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Icon(
                Icons.more_vert,
              )
            ],
          )
        ],
      ),
    );
  }
}
