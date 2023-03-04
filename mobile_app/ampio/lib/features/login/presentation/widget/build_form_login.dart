import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/widgets/custom_textfield.dart';
import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/utils/constants/route_path.dart';

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
              labelButton: const Text('SE CONNECTER'),
              // TODO : redirection in home screen
              onPressed: () => {},
            ),
          ),
          const SizedBox(height: 20,),
          Text(
            'Ou',
            style: GoogleFonts.poppins(
                color: Colors.white
            ),
          ),
          SizedBox(height: 10.h,),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              borderSide: true,
              backgroundColor: Colors.transparent,
              labelButton: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.qr_code_scanner),
                  SizedBox(width: 10.h,),
                  Text(
                    'Scanner le code QR',
                    style: GoogleFonts.poppins(
                      color: Colors.white
                    ),
                  )
                ],
              ),
              onPressed: () => context.go(RoutePath.scanPath),
            ),
          ),
        ],
      ),
    );
  }
  }
