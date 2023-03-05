import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/colors/app_colors.dart';

class CustomizedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomizedAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      leadingWidth: 148.w,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: EdgeInsets.only(left: 20.0.w),
        child: Image.asset(
          'assets/logo/ampioLogo.png',
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Icon(
            Icons.menu,
            size: 30.0,
            color: AppColors.greenAccentSecondary,
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 70.0.h);
}