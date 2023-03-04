import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/search_bar.dart';
import '../../../../features/profile/presentation/widget/question_item.dart';

class Questions extends StatelessWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SearchBar(),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              itemBuilder: (context,index) {
                return QuestionItem();
              },
              separatorBuilder: (context,index) {
                return const SizedBox(height: 10,);
              },
            ),
          )
        ],
      ),
    );
  }
}
