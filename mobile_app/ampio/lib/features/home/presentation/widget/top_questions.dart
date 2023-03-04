import 'package:ampio/core/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';

class TopQuestions extends StatelessWidget {

  const TopQuestions({Key? key});

  @override
  Widget build(BuildContext context) {

    return const PostCard(
      profileImage: 'assets/images/person1.jpg',
      name: 'Jane Doe',
      createdAt: '1 min',
      content: 'Group Array by Object key where key is an object',
      topic: 'JavaScript',
    );
  }
}