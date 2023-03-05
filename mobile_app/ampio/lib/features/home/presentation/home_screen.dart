import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/presentation/widgets/post_card.dart';
import '../../../core/utils/colors/app_colors.dart';
import 'widget/blurred_container.dart';
import 'widget/search_field.dart';
import 'widget/sharing_lists.dart';
import 'widget/topic_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTopQuestions = true;
  bool isRecentQuestions = false;
  bool isThisWeekQuestions = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.greyThirdly,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              right: -25.0.w,
              top: -25.0.h,
              child: BlurredContainer(
                color: AppColors.greenSecondary,
              ),
            ),
            Positioned(
              left: -38.w,
              top: 588.h,
              child: BlurredContainer(
                color: AppColors.pinkPrimary,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.w),
                    const Center(child: SearchField()),
                    SizedBox(height: 17.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'TOPIQUES',
                          style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Voir tout',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 89.h, child: const TopicList()),
                    SizedBox(height: 22.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'QUESTIONS',
                          style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Voir tout',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 45.h, child: _buildChipList()),
                    SizedBox(height: 12.h),
                    const PostCard(
                      profileImage: 'assets/images/person1.jpg',
                      name: 'Jane Doe',
                      createdAt: '1 min',
                      content: 'Group Array by Object key where key is an object',
                      topic: 'JavaScript',
                    ),
                    SizedBox(height: 22.h),
                    Text(
                      'PARTAGE',
                      style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    SizedBox(height: 12.h),
                    const SharingLists(),
                    SizedBox(height: 15.h),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipList() {
    TextStyle style1 = GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white
    );
    TextStyle style2 = GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black
    );

    return ListView(
      scrollDirection: Axis.horizontal,
      primary: false,
      children: [
        ChoiceChip(
          selected: isTopQuestions,
          onSelected: (value) {
            setState(() {
              isTopQuestions = value;
              isRecentQuestions = !value;
              isThisWeekQuestions = !value;
            });
          },
          selectedColor: AppColors.darkPrimary,
          label: Text(
              'Top question',
              style: style1
          ),
        ),
        SizedBox(width: 15.w),
        ChoiceChip(
          selected: isRecentQuestions,
          selectedColor: AppColors.darkPrimary,
          onSelected: (value) {
            setState(() {
              isTopQuestions = !value;
              isRecentQuestions = value;
              isThisWeekQuestions = !value;
            });
          },
          disabledColor: Colors.transparent,
          side: const BorderSide(
              color: Colors.grey
          ),
          label: Text(
              'Récents',
              style: style2
          ),
        ),
        SizedBox(width: 15.w),
        ChoiceChip(
          selected: isThisWeekQuestions,
          selectedColor: AppColors.darkPrimary,
          onSelected: (value) {
            setState(() {
              isTopQuestions = !value;
              isRecentQuestions = !value;
              isThisWeekQuestions = value;
            });
          },
          disabledColor: Colors.transparent,
          side: const BorderSide(
              color: Colors.grey
          ),
          label: Text(
              'Cette semaine',
              style: style2
          ),
        ),
      ],
    );
  }
}
