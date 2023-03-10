import 'package:ampio/features/home/presentation/all_questions_screen.dart';
import 'package:ampio/features/response/presentation/widget/code_editor.dart';
import 'package:ampio/features/topics/presentation/topics_screen.dart';
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
      GoRoute(
        path: RoutePath.scanPath,
        builder: (context, state) => const ScanScreen(),
      ),
      GoRoute(
          path: '${RoutePath.responsePath}/:post_id',
          builder: (context, state) {
            return ResponseScreen(
              postId: state.params["post_id"]!,
            );
          }),
      GoRoute(
        path: RoutePath.settingsPath,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: RoutePath.allQuestionsPath,
        builder: (context, state) => const AllQuestionsScreen(),
      ),
      GoRoute(
        path: '${RoutePath.codeEditor}/:post_id',
        builder: (context, state){
          return CodeEditor(
            postId: state.params["post_id"]!,
          );
        },
      ),
      GoRoute(path: RoutePath.topics, builder: (context,state) {
        return TopicsScreen();
      })
    ],
  );
}
