import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/presentation/widgets/custom_textfield.dart';
import '../../../../core/presentation/widgets/custom_button.dart';

class BuildFormLogin extends StatelessWidget {
  const BuildFormLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const CustomTextField(
            hintText: 'Votre e-mail',
          ),
          SizedBox(height: 35.h,),
          const CustomTextField(
            hintText: 'Votre mot de passe',
          ),
          SizedBox(height: 35.h,),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              labelButton: const Text('CONNECTER'),
              // TODO : redirection in home screen
              onPressed: () => {},
            ),
          )
        ],
      ),
    );
  }
  }
