import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/presentation/bloc/user/user_bloc.dart';
import '../../../../core/presentation/widgets/custom_textfield.dart';
import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/utils/colors/app_colors.dart';
import '../../../../core/utils/constants/route_path.dart';
import '../bloc/authenticate_with_form_event.dart';

class BuildFormLogin extends StatefulWidget {
  const BuildFormLogin({Key? key}) : super(key: key);

  @override
  State<BuildFormLogin> createState() => _BuildFormLoginState();
}

class _BuildFormLoginState extends State<BuildFormLogin> {
  late final TextEditingController _identityController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _identityController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = context.read<UserBloc>();

    return BlocListener<UserBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          print(state.user);
          context.go(RoutePath.homePath);
        } else if (state.status == AuthStatus.unauthenticated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Echec de la connexion',
                style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              backgroundColor: AppColors.greenPrimary,
              dismissDirection: DismissDirection.horizontal,
            ),
          );
        }
      },
      child: Form(
        child: Column(
          children: [
            CustomTextField(
              controller: _identityController,
              hintText: 'Votre e-mail',
            ),
            SizedBox(height: 35.h,),
            CustomTextField(
              controller: _passwordController,
              hintText: 'Votre mot de passe',
            ),
            SizedBox(height: 35.h,),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                labelButton: const Text('SE CONNECTER'),
                // TODO : redirection in home screen
                onPressed: () => userBloc.add(
                  AuthenticateWithFormEvent(
                    identity: _identityController.text,
                    password: _passwordController.text,
                  ),
                )
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
                onPressed: () => context.push(RoutePath.scanPath),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
