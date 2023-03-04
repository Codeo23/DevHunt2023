import 'package:go_router/go_router.dart';

import '../../../core/utils/constants/route_path.dart';
import '../../../features/welcome/presentation/welcome_screen.dart';
import '../../features/home/presentation/home.dart';
import '../../../features/login/presentation/login_screen.dart';
import '../../../features/scan/presentation/scan_screen.dart';
import '../../../features/response/presentation/response_screen.dart';

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
        builder: (context,state) => const ResponseScreen()
      )
    ],
  );
}
