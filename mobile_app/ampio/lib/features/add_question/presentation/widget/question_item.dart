import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/widgets/custom_textfield.dart';
import '../../../../core/utils/colors/app_colors.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({super.key, required this.titleField,required this.hintText});

  final String titleField;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleField,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5,),
          CustomTextField(
            hintText: hintText,
            hintStyle: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 16.sp
            ),
            fillColor: AppColors.greyPrimary,
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
