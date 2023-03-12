import 'dart:math';

import 'package:ampio/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          final random = Random();
          final options = ['C#.jpg', 'JAVA.jpg', 'JS.png', 'uml.jpg'];
          final randomIndex = random.nextInt(options.length);
          final randomOption = options[randomIndex];
          return Avatar(
            borderRadius: 35,
            imageProvider: AssetImage('assets/images/$randomOption'),
          );
        },
        separatorBuilder: (_, index) => const SizedBox(
          width: 5,
        ),
      );
    });
  }
}
