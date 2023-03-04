import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors/app_colors.dart';

class ChipList extends StatelessWidget {

  const ChipList({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle style1 = GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white
    );
    TextStyle style2 = GoogleFonts.poppins(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Colors.black
    );

    return ListView(
      scrollDirection: Axis.horizontal,
      primary: false,
      children: [
        ChoiceChip(
          selected: true,
          selectedColor: AppColors.darkPrimary,
          label: Text(
            'Top question',
            style: style1
          ),
        ),
        SizedBox(width: 15.w),
        ChoiceChip(
          selected: false,
          disabledColor: Colors.transparent,
          side: const BorderSide(
            color: Colors.grey
          ),
          label: Text(
            'Récents',
            style: style2
          ),
        ),
        SizedBox(width: 15.w),
        ChoiceChip(
          selected: false,
          disabledColor: Colors.transparent,
          side: const BorderSide(
            color: Colors.grey
          ),
          label: Text(
            'Cette semaine',
            style: style2
          ),
        ),
      ],
    );
  }
}