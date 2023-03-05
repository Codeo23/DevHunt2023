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
          borderRadius: 45.r,
          imageProvider: const AssetImage(
            'assets/images/JS.png',
          ),
        ),
        Avatar(
          borderRadius: 45.r,
          imageProvider: const AssetImage(
            'assets/images/c#.jpg',

          ),
        ),
        Avatar(
          borderRadius: 45.r,
          imageProvider: const AssetImage(
            'assets/images/JAVA.jpg',
          ),
        ),
        Avatar(
          borderRadius: 45.r,
          imageProvider: const AssetImage(
            'assets/images/uml.jpg',
          ),
        ),
      ],
    );
  }


}