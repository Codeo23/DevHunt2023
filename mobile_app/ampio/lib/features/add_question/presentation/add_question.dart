import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../features/add_question/presentation/widget/question_item.dart';
import '../../../../features/add_question/presentation/widget/available_choice_card.dart';
import '../../../../core/presentation/widgets/gradient_button.dart';
import '../../../../core/utils/colors/app_colors.dart';

class AddQuestion extends StatelessWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.8,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(55),
          topLeft: Radius.circular(55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          QuestionItem(titleField: 'Topiques', hintText: 'ex : typescript'),
          QuestionItem(titleField: 'Question', hintText: 'Poser votre question'),
          QuestionItem(titleField: 'Description', hintText: 'Description du problème'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AvailableChoiceCard(image: 'assets/images/link.png', title: 'Liens'),
              AvailableChoiceCard(image: 'assets/images/file.png', title: 'Fichier et doc'),
              AvailableChoiceCard(image: 'assets/images/img.png', title: 'Images'),
            ],
          ),
          Expanded(child: GradientButton(
            labelButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Poser la question',
                  style: GoogleFonts.poppins(fontSize: 20.sp,color: Colors.white),
                ),
              ],
            ),
            gradientColor: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                AppColors.orangePrimary,
                const Color.fromRGBO(224, 141, 2, 1),
              ],
            ),
            width: double.infinity,
          ),)
        ],
      ),
    );
  }
}
