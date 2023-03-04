import 'package:ampio/features/login/presentation/login_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils/constants/route_path.dart';
import '../../../features/welcome/presentation/welcome_screen.dart';
import '../../features/home/presentation/home.dart';

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
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePath.homePath,
        builder: (context, state) => const Home(),
      ),
    ],
  );
}
