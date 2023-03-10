
import 'package:ampio/features/home/presentation/all_questions_screen.dart';
import 'package:ampio/features/response/presentation/widget/code_editor.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants/route_path.dart';
import '../../../features/welcome/presentation/welcome_screen.dart';
import '../../features/home/presentation/home.dart';
import '../../../features/login/presentation/login_screen.dart';
import '../../../features/scan/presentation/scan_screen.dart';
import '../../../features/response/presentation/response_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';

abstract class AppRouter {
  static GoRouter configurations = GoRouter(
    initialLocation: RoutePath.loginPath,
    routes: [
      GoRoute(
        path: RoutePath.welcomePath,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RoutePath.loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePath.homePath,
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: RoutePath.scanPath,
        builder: (context, state) => const ScanScreen(),
      ),
      GoRoute(
          path: RoutePath.responsePath,
          builder: (context, state) => const ResponseScreen()),
      GoRoute(
        path: RoutePath.settingsPath,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: RoutePath.allQuestionsPath,
        builder: (context,state) => const AllQuestionsScreen(),
      ),
      GoRoute(
        path: RoutePath.codeEditor,
        builder: (context,state) =>  const CodeEditor(),
      )
    ],
  );
}
