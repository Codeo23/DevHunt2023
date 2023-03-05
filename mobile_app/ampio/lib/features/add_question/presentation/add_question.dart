import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../features/add_question/presentation/widget/question_item.dart';
import '../../../../features/add_question/presentation/widget/available_choice_card.dart';
import '../../../../core/presentation/widgets/gradient_button.dart';
import '../../../../core/utils/colors/app_colors.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({Key? key}) : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  late final TextEditingController _topicController;
  late final TextEditingController _questionController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _topicController = TextEditingController();
    _questionController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _topicController.dispose();
    _questionController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.75,
      ),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(55),
          topLeft: Radius.circular(55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          QuestionItem(
            titleField: 'Topiques',
            hintText: 'ex : typescript',
            controller: _topicController,
          ),
          QuestionItem(
            titleField: 'Question',
            hintText: 'Posez votre question',
            controller: _questionController,
          ),
          QuestionItem(
            titleField: 'Description',
            hintText: 'Description du problème',
            controller: _descriptionController,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                AvailableChoiceCard(
                  image: 'assets/images/link.png',
                  title: 'Liens',
                ),
                SizedBox(width: 10,),
                AvailableChoiceCard(
                  image: 'assets/images/file.png',
                  title: 'Fichier et doc',
                ),
                SizedBox(width: 10,),
                AvailableChoiceCard(
                  image: 'assets/images/img.png',
                  title: 'Images',
                ),
              ],
            ),
          ),
          GradientButton(
            height: 50,
            labelButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Poser la question',
                  style: GoogleFonts.poppins(
                      fontSize: 20.sp, color: Colors.white),
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
          )
        ],
      ),
    );
  }
}
