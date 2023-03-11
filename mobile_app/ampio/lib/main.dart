import 'package:ampio/core/domain/data/remote/repository/topic_repository.dart';
import 'package:ampio/features/topics/presentation/bloc/topic_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';

import 'core/router/app_router.dart';
import 'core/domain/data/remote/repository/auth_repository.dart';
import 'core/domain/data/remote/repository/post_repository.dart';
import 'core/presentation/bloc/post/post_bloc.dart';
import 'core/presentation/bloc/user/user_bloc.dart';
import 'core/domain/data/remote/repository/response_repository.dart';
import 'features/response/presentation/bloc/response_bloc.dart';

import 'core/utils/colors/app_colors.dart';
import 'core/utils/constants/topic.dart';

Future<void> _onBackgroundMessage(RemoteMessage message) async {
  print('background message ${message.notification?.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final messaging = FirebaseMessaging.instance;
  await messaging.subscribeToTopic(Topic.postAdded);
  FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
  FirebaseMessaging.onMessage.listen((RemoteMessage event) {
    showSimpleNotification(
        Text(
          event.notification?.body ?? "Nouvelle publication disponible",
          style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.white),
        ),
        elevation: 1.0,
        background: AppColors.greenAccentPrimary);
  });
  print('Subscribed to topic ${Topic.postAdded}');
  runApp(const AmpioApp());
}

class AmpioApp extends StatelessWidget {
  const AmpioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserBloc(AuthRepository())),
          BlocProvider(create: (context) => PostBloc(PostRepository())),
          BlocProvider(create: (context) => ResponseBloc(ResponseRepository())),
          BlocProvider(create: (context) => TopicBloc(TopicRepository())..add(const TopicGetsEvent())),
        ],
        child: ScreenUtilInit(
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
        ),
      ),
    );
  }
}
