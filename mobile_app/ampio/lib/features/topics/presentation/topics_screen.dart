import 'dart:math';

import 'package:ampio/core/domain/entity/topic_entity.dart';
import 'package:ampio/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:ampio/features/topics/presentation/widget/topic_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/colors/app_colors.dart';
import '../../../core/domain/entity/post_entity.dart';
import '../../../core/presentation/bloc/post/post_bloc.dart';
import '../../../core/presentation/widgets/post_card.dart';
import '../../../../features/home/presentation/widget/blurred_container.dart';
import '../../../features/home/presentation/widget/search_field.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicBloc, TopicState>(
      builder: (context, state) => Scaffold(
        body: Container(
          color: AppColors.greyThirdly,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                right: -25.0,
                top: -25.0,
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
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    const Center(child: SearchField()),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => context.pop(),
                            icon: const Icon(
                              Icons.chevron_left,
                              size: 30,
                            )),
                        Text(
                          'TOPIQUES',
                          style: GoogleFonts.poppins(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: state.topics.length,
                            itemBuilder: (context, index) {
                              final random = Random();
                              final options = ['C#.jpg', 'JAVA.jpg', 'JS.png', 'uml.jpg'];
                              final randomIndex = random.nextInt(options.length);
                              final randomOption = options[randomIndex];
                              final TopicEntity topic = state.topics[index];
                              return TopicItem(titleTopic: topic.topic,randomOption: randomOption,);
                            }))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
