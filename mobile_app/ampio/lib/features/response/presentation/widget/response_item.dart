import 'package:ampio/core/config/network_config.dart';
import 'package:ampio/core/domain/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors/app_colors.dart';

class ResponseItem extends StatelessWidget {
  const ResponseItem({super.key, this.content, this.filePath,this.user});

  final String? content;
  final String? filePath;
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    print(user);
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: AppColors.greyPrimary,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.5),
                child: Image.network(
                  '${NetworkConfig.baseUrl}/users/${user!.avatar!}',
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
                    user!.username ?? '',
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
          const SizedBox(height: 10,),
          Text(
            content ?? '',
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: content != '' ? 10 : 0,),
          filePath != ''
              ? Image.network(
                  '${NetworkConfig.baseUrl}/comments/${filePath!}',
                  fit: BoxFit.cover,
                )
              : const SizedBox(),
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
