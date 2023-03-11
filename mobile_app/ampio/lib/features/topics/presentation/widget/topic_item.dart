import 'package:ampio/core/presentation/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicItem extends StatelessWidget {
  const TopicItem({
    Key? key,
    required this.titleTopic,
  }) : super(key: key);

  final String titleTopic;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // TODO : change image from server
        Avatar(
          borderRadius: 35,
          imageProvider: const AssetImage(
            'assets/images/JS.png',
          ),
        ),
        Text(
          titleTopic,
          style: GoogleFonts.poppins(fontSize: 14.sp),
        )
      ],
    );
  }
}
