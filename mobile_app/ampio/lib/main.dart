import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/router/app_router.dart';

void main() {
  runApp(const AmpioApp());
}

class AmpioApp extends StatelessWidget {
  const AmpioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
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
      designSize: const Size(428, 926),
    );
  }
}
