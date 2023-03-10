import 'package:ampio/core/presentation/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Avatar(
          borderRadius: 45.r,
          imageProvider: const AssetImage(
            'assets/images/c#.jpg',
          ),
        ),
        Text('Javascript')
      ],
    );
  }
}
