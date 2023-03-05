import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/app_router.dart';
import 'core/domain/data/remote/repository/auth_repository.dart';
import 'core/presentation/bloc/user/user_bloc.dart';

void main() {
  runApp(const AmpioApp());
}

class AmpioApp extends StatelessWidget {
  const AmpioApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(AuthRepository()),
      child: ScreenUtilInit(
        builder: (context,child) {
          return MaterialApp.router(
            title: 'Ampio',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.configurations,
          );
        },
        designSize: const Size(428,926),
      ),
    );
  }
}