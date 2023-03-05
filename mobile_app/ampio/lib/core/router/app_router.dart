import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants/route_path.dart';
import '../../../features/welcome/presentation/welcome_screen.dart';
import '../../features/home/presentation/home.dart';
import '../../../features/login/presentation/login_screen.dart';
import '../../../features/scan/presentation/scan_screen.dart';
import '../../../features/response/presentation/response_screen.dart';
import '../../../features/settings/presentation/settings_screen.dart';

abstract class AppRouter {
  static GoRouter configurations = GoRouter(
    initialLocation: RoutePath.welcomePath,
    routes: [
      GoRoute(
        path: RoutePath.welcomePath,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RoutePath.loginPath,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
          transitionDuration: const Duration(seconds: 2),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
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
    ],
  );
}
