import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router/app_router.dart';
import 'core/domain/data/remote/repository/auth_repository.dart';
import 'core/domain/data/remote/repository/post_repository.dart';
import '../../../core/domain/data/remote/repository/response_repository.dart';
import '../../../../features/response/presentation/bloc/response_add_bloc.dart';
import 'core/presentation/bloc/user/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AmpioApp());
}

class AmpioApp extends StatelessWidget {
  const AmpioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc(AuthRepository()),),
        BlocProvider(create: (context) => ResponseBloc(ResponseRepository()),),
      ],
      child: ScreenUtilInit(
        builder: (context,child) {
          return MaterialApp.router(
            title: 'Ampio',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.transparent,
            ),
          ),
            routerConfig: AppRouter.configurations,
          );
        },
        designSize: const Size(428,926),
      ),
    );
  }
}
