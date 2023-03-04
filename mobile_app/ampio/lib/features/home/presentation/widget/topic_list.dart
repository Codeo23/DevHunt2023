import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/widgets/avatar.dart';

class TopicList extends StatelessWidget {
  const TopicList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      scrollDirection: Axis.horizontal,
      children: [
        Avatar(
          borderRadius: 54.r,
          imageUrl: 'assets/images/JS.png',
        ),
        SizedBox(width: 29.5.w),
        Avatar(
          borderRadius: 54.r,
          imageUrl: 'assets/images/c#.jpg',
        ),
        SizedBox(width: 29.5.w),
        Avatar(
          borderRadius: 54.r,
          imageUrl: 'assets/images/JAVA.jpg',
        ),
        SizedBox(width: 29.5.w),
        Avatar(
          borderRadius: 54.r,
          imageUrl: 'assets/images/uml.jpg',
        ),
      ],
    );
  }


}