import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionItem extends StatelessWidget {
  const QuestionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25.r))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Group array by object key where keys is an object',
            style: GoogleFonts.poppins(fontSize: 14.sp),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.message,
                        color: Colors.grey,
                        size: 15.sp,
                      ),
                      Text(
                        ' 1.3k',
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 15.sp),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.grey,
                        size: 15.sp,
                      ),
                      Text(
                        ' 1.3k',
                        style: GoogleFonts.poppins(
                            color: Colors.grey, fontSize: 15.sp),
                      )
                    ],
                  ),
                ],
              ),
              Icon(Icons.more_vert, size: 20.sp,)
            ],
          )
        ],
      ),
    );
  }
}
