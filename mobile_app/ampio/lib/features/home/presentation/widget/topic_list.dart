import 'package:ampio/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/widgets/avatar.dart';

class TopicList extends StatelessWidget {
  const TopicList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopicBloc, TopicState>(builder: (context, state) {
      return ListView.separated(
        primary: false,
        scrollDirection: Axis.horizontal,
        itemCount: state.topics.length,
        itemBuilder: (context, state) {
          return  Avatar(
            borderRadius: 35,
            imageProvider: AssetImage('assets/images/JS.png'),
          );
        },
        separatorBuilder: (_, index) => const SizedBox(
          width: 5,
        ),
      );
    });
  }
}
