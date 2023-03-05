import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/domain/data/remote/repository/post_repository.dart';
import '../../../../core/presentation/bloc/post/post_bloc.dart';
import '../../../../core/presentation/widgets/post_card.dart';
import '../../../../core/utils/Enums/loading_status.dart';
import '../../../../core/utils/colors/app_colors.dart';

class TopQuestions extends StatelessWidget {

  const TopQuestions({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => PostBloc(PostRepository())..add(LoadPostEvent()),
      child: BlocBuilder<PostBloc, LoadPostState>(
        builder: (context, state) {
          if(state.status == LoadingStatus.loading) {
            return Expanded(
              child: Center(
                child: SpinKitFadingCircle(
                  color: AppColors.greenSecondary,
                  size: 50.0,
                )
              ),
            );
          } else if(state.status == LoadingStatus.success) {
            return ListView.builder(
              primary: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.posts?.length,
              itemBuilder: (context, index) {
                final post = state.posts![index];
                return PostCard(
                  profileImage: 'assets/images/avatar.png',
                  name: post.user.username,
                  content: '${post.title} \n ${post.content}',
                );
              },
            );
          } else {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.error_outline,
                      color: AppColors.yellowPrimary,
                      size: 60.sp,
                    ),
                  ),
                  Text(
                    'Impossible de charger les données',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greySecondary,
                    ),
                  ),
                ],
              ),
            );
          }
        }
      ),
    );
  }
}