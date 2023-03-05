import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBarItem extends StatelessWidget {

  final IconData icon;
  final BorderSide borderSide;
  final Function() onTap;

  const BottomNavBarItem({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.borderSide
  }): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 46.0.w,
      decoration: BoxDecoration(
        border: Border(
          top: borderSide,
        ),
      ),
      child: TextButton(
        onPressed: onTap,
        child: Icon(
          icon,
          size: 30.0.h,
          color: Colors.grey,
        ),
      ),
    );
  }
}