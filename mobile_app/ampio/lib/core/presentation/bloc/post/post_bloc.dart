import 'package:bloc/bloc.dart';

import '../../../../features/add_question/presentation/bloc/post_add_event.dart';
import '../../../domain/data/remote/repository/post_repository.dart';
import '../../../domain/usecase/post_usecase.dart';
import '../../../services/push_notification_service.dart';
import '../load_event.dart';
import '../../../domain/entity/post_entity.dart';
import '../../../utils/Enums/loading_status.dart';

part 'load_post_event.dart';
part 'load_post_state.dart';

class PostBloc extends Bloc<LoadPostEvent, LoadPostState> {

  final PostRepository postRepository;
  final PostUseCase postUseCase = PostUseCase();

  PostBloc(this.postRepository) : super(const LoadPostState()) {
    on<LoadPostEvent>((event, emit) => mapLoadPostEventToState(event, emit));
    on<PostAddEvent>((event, emit) => mapPostAddEventToState(event, emit));
  }

  void mapLoadPostEventToState(LoadPostEvent event, Emitter<LoadPostState> emit) async {

    emit(state.copyWith(status: LoadingStatus.loading));
    try {
      final posts = await postUseCase.convertPostsDataToPostEntity();
      emit(state.copyWith(posts: posts, status: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadingStatus.error));
    }
  }

  void mapPostAddEventToState(PostAddEvent event, Emitter<LoadPostState> emit) async {

    emit(state.copyWith(status: LoadingStatus.loading));
    try {
      await postRepository.addPost(
        question: event.question,
        description: event.description,
        topic: event.topic,
      );
      await PushNotificationService.sendPushNotification(event.question, event.description);
      emit(state.copyWith(status: LoadingStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadingStatus.error));
    }
  }
}