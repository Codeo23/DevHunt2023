import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/sharing_card.dart';
import '../../../../core/utils/colors/app_colors.dart';

class SharingLists extends StatelessWidget {

  const SharingLists({super.key});

  @override
  Widget build(BuildContext context) {

    return SharingCard(
      profileImage: 'assets/images/person1.jpg',
      name: 'Jane Doe',
      content: 'Ma meilleure site pour apprendre ReactJS',
      gradientColor: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          AppColors.greenAccentThirdly,
          AppColors.greenSecondary
        ]
      ),
      image: 'assets/images/reactjs.webp',
      sharedSubject: 'https://reactjs.org',
    );
  }
}