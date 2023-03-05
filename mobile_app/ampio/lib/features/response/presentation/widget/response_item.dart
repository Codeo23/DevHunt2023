import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors/app_colors.dart';

class ResponseItem extends StatelessWidget {
  const ResponseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.greyPrimary,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.5),
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  height: 25,
                  width: 25,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hasina BG',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 12.sp),
                  ),
                  Text(
                    '2h',
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 12.sp,
                    ),
                  )
                ],
              )
            ],
          ),
          Text(
            'To start with, you can create a JSONObject first using a json string and then a JSONArray object.'
            'Then iterate over this array and manipulate with nested objects.',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
            ),
          ),
          const Image(
            image: AssetImage('assets/images/code.png'),
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.bookmark,
                size: 20.sp,
              ),
              const SizedBox(
                width: 5,
              ),
              Icon(
                Icons.share_outlined,
                size: 20.sp,
              ),
            ],
          )
        ],
      ),
    );
  }
}
