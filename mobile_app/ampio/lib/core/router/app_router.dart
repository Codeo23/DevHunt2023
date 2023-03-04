import 'package:go_router/go_router.dart';

import '../../../core/utils/constants/route_path.dart';
import '../../../features/welcome/presentation/welcome_screen.dart';

abstract class AppRouter {
  static GoRouter configurations =
      GoRouter(initialLocation: RoutePath.welcomePath, routes: [
    GoRoute(
      path: RoutePath.welcomePath,
      builder: (context, state) => const WelcomeScreen(),
    ),
  ]);
}
