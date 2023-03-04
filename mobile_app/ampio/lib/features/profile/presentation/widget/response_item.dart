import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ResponseItem extends StatelessWidget {
  const ResponseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(
                'Hasina BG',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600, fontSize: 12.sp),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '1 min',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Text(
            'Group Array by Object key where key is an object',
            style: GoogleFonts.poppins(fontSize: 14.sp),
          ),
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
                      color: Colors.grey,
                      fontSize: 15.sp,
                    ),
                  )
                ],
              ),
            ],
          ),
          Text(
            'Votre réponse : ',
            style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14.sp),
          ),
          Text(
            'Not sure if lodash can help you there, I would do it manually. Grouping works as always, i.e. for each item, go through the already created groups, and then either add it to an existing group or start a new one. You just have to check for a full object instead of a single field:',
            style: GoogleFonts.poppins(fontSize: 13.sp),
          ),
          const Image(
            image: AssetImage('assets/images/code.png'),
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
