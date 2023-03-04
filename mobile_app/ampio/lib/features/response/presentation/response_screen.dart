import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../features/response/presentation/widget/response_item.dart';
import '../../../../core/presentation/widgets/blurred_container.dart';
import '../../../../features/response/presentation/widget/coms.dart';


class ResponseScreen extends StatelessWidget {
  const ResponseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: -20,
              right: -10,
              child: BlurredContainer(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.chevron_left),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Réponses',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Parsing JSON array and object in Android Studio',
                    style: GoogleFonts.poppins(fontSize: 16.sp),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Réponses',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 14.sp,
                      )
                    ],
                  ),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ResponseItem();
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: 5))
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/avatar.jpg',
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20,),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
